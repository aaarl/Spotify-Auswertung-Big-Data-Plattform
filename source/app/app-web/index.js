const dns = require("dns").promises;
const os = require("os");
const express = require("express");
const { addAsync } = require("@awaitjs/express");
const app = addAsync(express());
const mysqlx = require("@mysql/xdevapi");
const MemcachePlus = require("memcache-plus");
const Kafka = require("node-rdkafka");

let memcached = null;
let memcachedServers = [];

const databaseConfig = {
  user: "root",
  password: "mysecretpw",
  host: "my-database-service",
  port: 33060,
  schema: "spotifydb",
};

async function getMemcachedServers() {
  try {
    let queryResult = await dns.lookup("my-memcached", { all: true });
    let server = queryResult.map((x) => x.address + ":11211");

    // Only create a new object if the server list has changed
    if (memcachedServers.sort().toString() !== server.sort().toString()) {
      console.log("Updated memcached server list to ", server);
      memcachedServers = server;
      // Disconnect an existing client
      if (memcached) await memcached.disconnect();
      memcached = new MemcachePlus(memcachedServers);
    }
  } catch (exception) {
    console.log(`Memcached not found: ${exception}`);
    memcached = null;
  }
}

// Get data from cache if a cache exists yet
async function getFromCache(key) {
  if (!memcached) {
    console.log(
      `No memcached instance available, memcachedServers = ${memcachedServers}`
    );
    return null;
  }
  return await memcached.get(key);
}

// Initially try to connect to the memcached server and update the list
getMemcachedServers();
setInterval(() => getMemcachedServers(), 5000);

// Get the first column data from database for a specific query
async function getFromDatabaseFirst(query) {
  let session = await mysqlx.getSession(databaseConfig);

  console.log("Executing query " + query);
  let res = await session.sql(query).execute();
  let row = res.fetchOne();

  if (row) {
    console.log("Query result = ", row);
    return row[0];
  } else {
    return null;
  }
}

// Get the top ten artists sorted by timesListened
async function getArtistsFromDatabase() {
  let query = `SELECT * from live_spotify ORDER BY timesListened DESC LIMIT 10`;
  return getFromDatabase(query);
}

// Get the name from the artist
async function getNameFromArtist(artist) {
  let query =
    'SELECT artist from live_spotify WHERE artist = "' + artist + '" LIMIT 1';
  return getFromDatabaseFirst(query);
}

// Get all data from database for a specific query
async function getFromDatabase(query) {
  let session = await mysqlx.getSession(databaseConfig);

  console.log("Executing query " + query);
  let res = await session.sql(query).execute();
  let all = res.fetchAll();

  if (all) {
    console.log("Query result = ", all);
  }

  return all;
}

async function getTotalArtistsFromDatabase(artist) {
  let query =
    'SELECT total_cases from spotify_cases WHERE artist = "' +
    artist +
    '" LIMIT 1';
  const batchResult = await getFromDatabaseFirst(query);

  let streamingQuery =
    'SELECT sum(count) from live_spotify WHERE artists = "' +
    artist.toUpperCase() +
    '" LIMIT 1';
  const streamingResult = await getFromDatabaseFirst(streamingQuery);

  if (batchResult && streamingResult) {
    return batchResult + streamingResult;
  } else if (batchResult) {
    return batchResult;
  } else {
    return null;
  }
}

// Return all artists where spotify timesListened occurred
async function getAllArtists() {
  const query = "SELECT * FROM live_spotify";
  return getFromDatabase(query);
}

// Get the artists name for the alpha 2 abbrevation
async function getArtistName(artist) {
  return getData(
    artist,
    artist,
    getNameFromArtist
  );
}

// Get all web-requests
async function getAllWebRequestsFromDatabase() {
  let query = "SELECT url, count from web_requests";
  return getFromDatabase(query);
}

// Return the data for a speific memCache key or id in the db. The function f will be used to retrieve the data from the db.
async function getData(key, id, f) {
  let cachedata = await getFromCache(key);

  if (cachedata) {
    console.log(`Cache hit for key=${key}, cachedata = ${cachedata}`);
    return cachedata + " (cache hit)";
  } else {
    console.log(`Cache miss for key=${key}, querying database`);
    let data = await f(id);
    if (data) {
      console.log(`Got data=${data}, storing in cache`);
      if (memcached) await memcached.set(key, data, 30 /* seconds */);
      return data + " (cache miss)";
    } else {
      return "No data found";
    }
  }
}

// Return response
function send_response(response, data) {
  response.send(`
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
  let kafkaStream = new Kafka.Producer.createWriteStream(
    { "metadata.broker.list": "my-kafka-cluster-kafka-bootstrap:9092" },
    {},
    { topic: "web-requests" }
  );

  // Set error handler for a kafka stream
  kafkaStream.on("error", function (err) {
    console.error("Error in our kafka stream");
    console.error(err);
  });

  // Queue message
  console.log("Send to Kafka Queue = " + message);
  var queuedSuccess = kafkaStream.write(Buffer.from(message));

  if (queuedSuccess) {
    console.log("We queued our message!");
  } else {
    console.log("Too many messages in our queue already");
  }
}

// Send Home Page
app.get("/", function (request, response) {
  response.send(`Welcome, this is the Big-Data project from
			<ul>
        <li>Arl Ferhati</li>
        <li>Lucas Zodel</li>
        <li>Mark Bühler</li>
        <li>Maximilian Höger</li>
        <li>Sven Fischer</li>
			</ul>
			The following URL commands are supported:
			<ul>
				<li>artists/[genre] - the genre</li>
				<li>artists/[timesListened] - listing of the top ten most popular artists, the ranking is sorted by the their song times listened or most popular song</li>
                <li>webrequests - Returns all received requests grouped by the URL</li>
			</ul>`);
});

// get all artists
app.getAsync("/artists", async function (request, response) {
  sendToKafka(request.url);

  const data = await getAllArtists();
  console.log(data);
  let result = `<table>
	<tr>
    <th>Artist</th>
    <th>Most streamed song</th>
	  <th>Times Listened</th>
	  <th>Genre</th>
	</tr>`;
  for (const row of data) {
    result += `<tr>
		<td>${row[1]}</td>
		<td>${row[2]}</td>
		<td>${row[3]}</td>
		<td>${row[4]}</td>
	  </tr>`;
  }
  result += `</table>`;
  send_response(response, result);
});

// Receive the request for the artists id
app.getAsync("/artists/:id", async function (request, response) {
  let artistsId = request.params["id"];
  let artistsKey = "artists_" + artistsId;

  sendToKafka(request.url);

  let timesListened = await getData(
    artistsKey + "timesListened",
    artistsId,
    getTotalArtistsFromDatabase
  );
  console.log(`Got timesListened=${artistsKey}`);

  let artistName = await getArtistName(artistsId);
  console.log(`Name=${artistName}`);

  let ret = `Numbers for ${artistName}<ul>
					<li>Total TimesListened: ${timesListened}</li>
				</ul>`;
  send_response(response, ret);
});

// Set port for web app to listen
app.set("port", process.env.PORT || 8080);

app.listen(app.get("port"), function () {
  console.log("Node app is running at localhost:" + app.get("port"));
});

// Receive the request for all web-requests so far
app.getAsync("/webrequests", async function (request, response) {
  const allWebRequests = await getAllWebRequestsFromDatabase();
  console.log("Got all web-requests");

  let htmlAllWebRequest = "";
  allWebRequests.forEach((row) => {
    htmlAllWebRequest += `<li>URL: ${row[0]}, Count: ${row[1]}</li>`;
  });
  const ret = `All web requests:<ul>
					${htmlAllWebRequest}
				</ul>`;
  send_response(response, ret);
});

// Receive the request for the list of the top ten artists
app.getAsync("/artists/:type", async function (request, response) {
  let type = request.params["type"];

  sendToKafka(request.url);

  let queryResult = await getArtistsFromDatabase();
  let queryResultLength = queryResult.length;

  var ret = "<br>Artist | Most popular song | Times Listened | Genre<br>";

  for (var i = 0; i < queryResultLength; ++i) {
    console.log(i + " : " + queryResult[i]);
    ret = ret + `${queryResult[i][0]} | ${queryResult[i][1]} | ${queryResult[i][2]} | ${queryResult[i][3]} <br>`;
  }

  send_response(response, ret);
});
