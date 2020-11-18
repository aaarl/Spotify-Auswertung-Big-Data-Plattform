const os = require('os')
const dns = require('dns').promises
const { program: optionparser } = require('commander')
const { Kafka } = require('kafkajs')
const mysqlx = require('@mysql/xdevapi');
const MemcachePlus = require('memcache-plus');
const express = require('express')

const app = express()
const cacheTimeSecs = 15
const numberOfMissions = 30

// Main method
app.listen(options.port, function () {
	console.log("Node app is running at http://localhost:" + options.port)
});

// Command-line options
let options = optionparser
	.storeOptionsAsProperties(true)
	// Web server
	.option('--port <port>', "Web server port", 3000)
	// Kafka options
	.option('--kafka-broker <host:port>', "Kafka bootstrap host:port", "my-cluster-kafka-bootstrap:9092")
	.option('--kafka-topic-tracking <topic>', "Kafka topic to tracking data send to", "tracking-data")
	.option('--kafka-client-id < id > ', "Kafka client ID", "tracker-" + Math.floor(Math.random() * 100000))
	// Memcached options
	.option('--memcached-hostname <hostname>', 'Memcached hostname (may resolve to multiple IPs)', 'my-memcached-service')
	.option('--memcached-port <port>', 'Memcached port', 11211)
	.option('--memcached-update-interval <ms>', 'Interval to query DNS for memcached IPs', 5000)
	// Database options
	.option('--mysql-host <host>', 'MySQL host', 'my-app-mysql-service')
	.option('--mysql-port <port>', 'MySQL port', 33060)
	.option('--mysql-schema <db>', 'MySQL Schema/database', 'spotifydb')
	.option('--mysql-username <username>', 'MySQL username', 'root')
	.option('--mysql-password <password>', 'MySQL password', 'mysecretpw')
	// Misc
	.addHelpCommand()
	.parse()
	.opts()


// Database Configuration
const dbConfig = {
	host: options.mysqlHost,
	port: options.mysqlPort,
	user: options.mysqlUsername,
	password: options.mysqlPassword,
	schema: options.mysqlSchema
};

async function executeQuery(query, data) {
	let session = await mysqlx.getSession(dbConfig);
	return await session.sql(query, data).bind(data).execute()
}

// Memache Configuration
//Connect to the memcached instances
let memcached = null
let memcachedServers = []

async function getMemcachedServersFromDns() {
	try {
		// Query all IP addresses for this hostname
		let queryResult = await dns.lookup(options.memcachedHostname, { all: true })

		// Create IP:Port mappings
		let servers = queryResult.map(el => el.address + ":" + options.memcachedPort)

		// Check if the list of servers has changed
		// and only create a new object if the server list has changed
		if (memcachedServers.sort().toString() !== servers.sort().toString()) {
			console.log("Updated memcached server list to ", servers)
			memcachedServers = servers

			//Disconnect an existing client
			if (memcached)
				await memcached.disconnect()

			memcached = new MemcachePlus(memcachedServers);
		}
	} catch (e) {
		console.log("Unable to get memcache servers", e)
	}
}

//Initially try to connect to the memcached servers, then each 5s update the list
getMemcachedServersFromDns()
setInterval(() => getMemcachedServersFromDns(), options.memcachedUpdateInterval)

//Get data from cache if a cache exists yet
async function getFromCache(key) {
	if (!memcached) {
		console.log(`No memcached instance available, memcachedServers = ${memcachedServers}`)
		return null;
	}
	return await memcached.get(key);
}

// Kafka Configuration
// Kafka connection
const kafka = new Kafka({
	clientId: options.kafkaClientId,
	brokers: [options.kafkaBroker],
	retry: {
		retries: 0
	}
})

const producer = kafka.producer()
// End

// Send tracking message to Kafka
async function sendTrackingMessage(data) {
	//Ensure the producer is connected
	await producer.connect()

	//Send message
	await producer.send({
		topic: options.kafkaTopicTracking,
		messages: [
			{ value: JSON.stringify(data) }
		]
	})
}
// End


// HTML helper to send a response to the client
function sendResponse(res, html, cachedResult) {
	res.send(`<!DOCTYPE html>
		<html lang="en">
		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>Big Data Use-Case Demo</title>
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mini.css/3.0.1/mini-default.min.css">
			<script>
				function fetchRandomMissions() {
					const maxRepetitions = Math.floor(Math.random() * 200)
					document.getElementById("out").innerText = "Fetching " + maxRepetitions + " random missions, see console output"
					for(var i = 0; i < maxRepetitions; ++i) {
						const missionId = Math.floor(Math.random() * ${numberOfMissions})
						console.log("Fetching mission id " + missionId)
						fetch("/missions/sts-" + missionId, {cache: 'no-cache'})
					}
				}
			</script>
		</head>
		<body>
			<h1>Big Data Use Case Demo</h1>
			<p>
				<a href="javascript: fetchRandomMissions();">Randomly fetch some missions</a>
				<span id="out"></span>
			</p>
			${html}
			<hr>
			<h2>Information about the generated page</h4>
			<ul>
				<li>Server: ${os.hostname()}</li>
				<li>Date: ${new Date()}</li>
				<li>Using ${memcachedServers.length} memcached Servers: ${memcachedServers}</li>
				<li>Cached result: ${cachedResult}</li>
			</ul>
		</body>
	</html>
	`)
}

// TODO AF: change entire section (music listing instead of missions listing)
// Start page
// Get list of missions (from cache or db)
async function getMissions() {
	const key = 'missions'
	let cachedata = await getFromCache(key)

	if (cachedata) {
		console.log(`Cache hit for key=${key}, cachedata = ${cachedata}`)
		return { result: cachedata, cached: true }
	} else {
		console.log(`Cache miss for key=${key}, querying database`)
		let executeResult = await executeQuery("SELECT mission FROM missions", [])
		let data = executeResult.fetchAll()
		if (data) {
			let result = data.map(row => row[0])
			console.log(`Got result=${result}, storing in cache`)
			if (memcached)
				await memcached.set(key, result, cacheTimeSecs);
			return { result, cached: false }
		} else {
			throw "No missions data found"
		}
	}
}

// Get popular missions (from db only)
async function getPopular(maxCount) {
	const query = "SELECT mission, count FROM popular ORDER BY count DESC LIMIT ?"
	return (await executeQuery(query, [maxCount]))
		.fetchAll()
		.map(row => ({ mission: row[0], count: row[1] }))
}

// Return HTML for start page
app.get("/", (req, res) => {
	const topX = 10;
	Promise.all([getMissions(), getPopular(topX)]).then(values => {
		const missions = values[0]
		const popular = values[1]

		const missionsHtml = missions.result
			.map(m => `<a href='missions/${m}'>${m}</a>`)
			.join(", ")

		const popularHtml = popular
			.map(pop => `<li> <a href='missions/${pop.mission}'>${pop.mission}</a> (${pop.count} views) </li>`)
			.join("\n")

		const html = `
			<h1>Top ${topX} Missions</h1>
			<p>
				<ol style="margin-left: 2em;"> ${popularHtml} </ol>
			</p>
			<h1>All Missions</h1>
			<p> ${missionsHtml} </p>
		`
		sendResponse(res, html, missions.cached)
	})
})

// Get a specific mission (from cache or DB)
async function getMission(mission) {
	const query = "SELECT mission, heading, description FROM missions WHERE mission = ?"
	const key = 'mission_' + mission
	let cachedata = await getFromCache(key)

	if (cachedata) {
		console.log(`Cache hit for key=${key}, cachedata = ${cachedata}`)
		return { ...cachedata, cached: true }
	} else {
		console.log(`Cache miss for key=${key}, querying database`)

		let data = (await executeQuery(query, [mission])).fetchOne()
		if (data) {
			let result = { mission: data[0], heading: data[1], description: data[2] }
			console.log(`Got result=${result}, storing in cache`)
			if (memcached)
				await memcached.set(key, result, cacheTimeSecs);
			return { ...result, cached: false }
		} else {
			throw "No data found for this mission"
		}
	}
}

app.get("/missions/:mission", (req, res) => {
	let mission = req.params["mission"]

	// Send the tracking message to Kafka
	sendTrackingMessage({
		mission,
		timestamp: Math.floor(new Date() / 1000)
	}).then(() => console.log("Sent to kafka"))
		.catch(e => console.log("Error sending to kafka", e))

	// Send reply to browser
	getMission(mission).then(data => {
		sendResponse(res, `<h1>${data.mission}</h1><p>${data.heading}</p>` +
			data.description.split("\n").map(p => `<p>${p}</p>`).join("\n"),
			data.cached
		)
	}).catch(err => {
		sendResponse(res, `<h1>Error</h1><p>${err}</p>`, false)
	})
});
