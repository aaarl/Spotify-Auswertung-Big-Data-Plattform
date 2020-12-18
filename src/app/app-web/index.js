const dns = require('dns').promises;
const os = require('os')
const express = require('express')
const { addAsync } = require('@awaitjs/express');
const app = addAsync(express());
const mysqlx = require('@mysql/xdevapi');
const MemcachePlus = require('memcache-plus');
const Kafka = require('node-rdkafka');

//Connect to the memcached instances
let memcached = null
let memcachedServers = []

// Database configuration according to README
const dbConfig = {
	user: 'root',
	password: 'mysecretpw',
	host: 'my-database-service',
	port: 33060,
	schema: 'spotifydb'
};

// Utility function for init Memcache Server objects
async function getMemcachedServersFromDns() {
	let queryResult = await dns.lookup('my-memcached-service', { all: true })
	let servers = queryResult.map(el => el.address + ":11211")

	// Only create a new object if the server list has changed
	if (memcachedServers.sort().toString() !== servers.sort().toString()) {
		console.log("Updated memcached server list to ", servers)
		memcachedServers = servers
		// Disconnect an existing client
		if (memcached)
			await memcached.disconnect()
		memcached = new MemcachePlus(memcachedServers);
	}
}

// Initially try to connect to the memcached servers, then each 5s update the list
getMemcachedServersFromDns()
setInterval(() => getMemcachedServersFromDns(), 5000)

// Get data from cache if a cache exists yet
async function getFromCache(key) {
	if (!memcached) {
		console.log(`No memcached instance available, memcachedServers = ${memcachedServers}`)
		return null;
	}
	return await memcached.get(key);
}

// Get the first column data from database for a specific query
async function getFromDatabaseFirst(query) {
	let session = await mysqlx.getSession(dbConfig);

	console.log("Executing query " + query)
	let res = await session.sql(query).execute()
	let row = res.fetchOne()

	if (row) {
		console.log("Query result = ", row)
		return row[0];
	} else {
		return null;
	}
}

// Get all data from database for a specific query
async function getFromDatabase(query) {
	let session = await mysqlx.getSession(dbConfig);

	console.log("Executing query " + query)
	let res = await session.sql(query).execute()
	let all = res.fetchAll()

	if (all) {
		console.log("Query result = ", all)
	}

	return all;
}

// Get the total cases for a specific artists from the db
async function getArtistsFromDatabase(type) {
	let query = `SELECT * from spotify_artists ORDER BY total_${type} DESC LIMIT 10`;
	return getFromDatabase(query);
}

// Get the total cases for a specific artists from the db
async function getArtistNameFromDatabase(alpha2) {
	let query = 'SELECT name from artists WHERE alpha2 = "' + alpha2 + '" LIMIT 1';
	return getFromDatabaseFirst(query);
}

// Get the total cases for a specific artists from the db
async function getTotalArtistsArtistFromDatabase(alpha2) {
	let query = 'SELECT total_cases from spotify_artists WHERE alpha2 = "' + alpha2 + '" LIMIT 1';
	const batchResult = await getFromDatabaseFirst(query);

	let streamingQuery = 'SELECT sum(count) from live_corona WHERE artists = "' + alpha2.toUpperCase() + '" LIMIT 1';
	const streamingResult = await getFromDatabaseFirst(streamingQuery);

	if (batchResult && streamingResult) {
		return (batchResult + streamingResult);
	} else if (batchResult) {
		return batchResult;
	} else {
		return null;
	}
}

// Get the total deaths for a specific artists from the db
async function getTotalDeathsArtistFromDatabase(alpha2) {
	let query = 'SELECT total_deaths from spotify_artists WHERE alpha2 = "' + alpha2 + '" LIMIT 1';
	return getFromDatabaseFirst(query);
}

// Return all artists where corona cases occurred
async function getAllCountries() {
	const query = 'SELECT * FROM spotify_artists';
	return getFromDatabase(query);
}

// Get the artists name for the alpha 2 abbrevation
async function getArtistName(alpha2) {
	return getData('artists_' + alpha2 + '_name', alpha2, getArtistNameFromDatabase);
}

// Get all web-requests
async function getAllWebRequestsFromDatabase() {
	let query = 'SELECT url, count from web_requests';
	return getFromDatabase(query);
}

// Return the data for a speific memCache key or id in the db. The function f will be used to retrieve the data from the db.
async function getData(key, id, f) {
	let cachedata = await getFromCache(key);

	if (cachedata) {
		console.log(`Cache hit for key=${key}, cachedata = ${cachedata}`)
		return cachedata + " (cache hit)";
	} else {
		console.log(`Cache miss for key=${key}, querying database`)
		let data = await f(id)
		if (data) {
			console.log(`Got data=${data}, storing in cache`)
			if (memcached)
				await memcached.set(key, data, 30 /* seconds */);
			return data + " (cache miss)";
		} else {
			return "No data found";
		}
	}
}
// Return the data for a speific memCache key or id in the db. The function f will be used to retrieve the data from the db.
async function getData2(key, id1, id2, f) {
	let cachedata = await getFromCache(key);

	if (cachedata) {
		console.log(`Cache hit for key=${key}, cachedata = ${cachedata}`)
		return cachedata + " (cache hit)";
	} else {
		console.log(`Cache miss for key=${key}, querying database`)
		let data = await f(id1, id2)
		if (data) {
			console.log(`Got data=${data}, storing in cache`)
			if (memcached)
				await memcached.set(key, data, 30 /* seconds */);
			return data + " (cache miss)";
		} else {
			return "No data found";
		}
	}
}

// Return response
function send_response(response, data) {
	response.send(`<h1>Hello k8s</h1>
			<ul>
				<li>Host ${os.hostname()}</li>
				<li>Date: ${new Date()}</li>
				<li>Memcached Servers: ${memcachedServers}</li>
				<li>Result is: ${data}</li>
			</ul>`);
}

// Send a message to the kafka stream
function sendToKafka(message) {
	// Connect to kafka bootstrap as producer
	let kafkaStream = new Kafka.Producer.createWriteStream({
		'metadata.broker.list': 'my-kafka-cluster-kafka-bootstrap:9092'
	}, {}, {
		topic: 'web-requests'
	});

	// Set error handler for a kafka stream
	kafkaStream.on('error', function (err) {
		console.error('Error in our kafka stream');
		console.error(err);
	})

	// Queue message
	console.log('Send to Kafka Queue = ' + message);
	var queuedSuccess = kafkaStream.write(Buffer.from(message));

	if (queuedSuccess) {
		console.log('We queued our message!');
	}
	else {
		console.log('Too many messages in our queue already');
	}
}

// Send Home Page
app.get('/', function (request, response) {
	response.send(`Welcome to the Spotify Big Data Plattform by
			<ul>
				<li>Arl Ferhati</li>
			</ul>
			The following URL commands are supported:
			<ul>
				<li>artists/[id] - id as ISO 3166-1 Alpha-2-code</li>
				<li>artists/[type] - Listing of the top ten most popular artists, the ranking is sorted by the type which could be song times listened or most popular song</li>
                <li>webrequests - Returns all received requests grouped by the URL</li>
			</ul>`);
});

// get all artists
app.getAsync('/artists', async function (request, response) {

	sendToKafka(request.url);

	const data = await getAllCountries();
	console.log(data);
	let result = `<table>
	<tr>
	  <th>Artist</th>
	  <th>Total Cases</th>
	  <th>Total Deaths</th>
	  <th>Total Tests</th>
	  <th>GDP per capita</th>
	  <th>Population(2018)</th>
	</tr>`;
	for (const row of data) {
		result += `<tr>
		<td>${row[5]}</td>
		<td>${row[1]}</td>
		<td>${row[2]}</td>
		<td>${row[7]}</td>
		<td>${row[8]}</td>
		<td>${row[3]}</td>
	  </tr>`;
	}
	result += `</table>`;
	send_response(response, result);
});


// Receive the request for the artists id
app.getAsync('/artists/:id', async function (request, response) {
	let artistsId = request.params["id"]
	let artistsKey = 'artists_' + artistsId;

	sendToKafka(request.url);

	let deaths = await getData(artistsKey + '_deaths', artistsId, getTotalDeathsArtistFromDatabase);
	console.log(`Got deaths=${deaths}`)
	let cases = await getData(artistsKey + '_cases', artistsId, getTotalArtistsArtistFromDatabase);
	console.log(`Got cases=${artistsKey}`)

	let name = await getArtistName(artistsId);
	console.log(`Got name=${name}`)

	let ret = `Numbers for ${name}<ul>
					<li>Total Cases: ${cases}</li>
					<li>Total Deaths: ${deaths}</li>
				</ul>`;
	send_response(response, ret);
});

// Receive the request for the list of the top ten artists
app.getAsync('/artists/:type', async function (request, response) {
	let type = request.params["type"];

	sendToKafka(request.url);

	let queryResult = await getArtistsFromDatabase(type) // 0 = alpha2, 1 = cases, 2 = deaths
	let queryResultLength = queryResult.length;

	var ret = '<br>Alpha3 | Total Cases | Total Deaths | Population 2018 | Alpha2 | Name | Continent | Total Tests | GDP per Capita<br>';

	for (var i = 0; i < queryResultLength; ++i) {
		console.log(i + " : " + queryResult[i]);
		ret = ret + `${queryResult[i][0]} | ${queryResult[i][1]} | ${queryResult[i][2]} | ${queryResult[i][3]} | ${queryResult[i][4]} | ${queryResult[i][5]} | ${queryResult[i][6]} | ${queryResult[i][7]}<br>`;
	}

	send_response(response, ret);
});

// Receive the request for all web-requests so far
app.getAsync('/webrequests', async function (request, response) {
	const allWebRequests = await getAllWebRequestsFromDatabase()
	console.log('Got all web-requests')

	let htmlAllWebRequest = '';
	allWebRequests.forEach((row) => {
		htmlAllWebRequest += `<li>URL: ${row[0]}, Count: ${row[1]}</li>`;
	});
	const ret = `All web requests:<ul>
					${htmlAllWebRequest}
				</ul>`;
	send_response(response, ret);
});

// Set port for web app to listen
app.set('port', (process.env.PORT || 8080))

app.listen(app.get('port'), function () {
	console.log("Node app is running at localhost:" + app.get('port'))
})
