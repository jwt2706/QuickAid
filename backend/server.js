const express = require("express");
const cors = require("cors");
const axios = require("axios");
const http = require('http');
const app = express();
const server = http.createServer(app);
const io = require('socket.io')(server);
const { LexRuntimeV2Client, PostTextCommand, RecognizeTextCommand } = require("@aws-sdk/client-lex-runtime-v2");

app.use(cors());
app.use(express.json());
require("dotenv").config()
var client = require('twilio')(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_TOKEN)

const lexruntime = new LexRuntimeV2Client({
  region: process.env.AWS_REGION,
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
  }
});

app.post("/transcribe", async (req, res) => {
  const transcriptionText = req.body.transcript;
  const data = await waitForResponse(transcriptionText);
 

  console.log("Received transcript:", transcriptionText);
  let cleandata = "";


  console.log("Data: ", data?.messages?.[0]?.content);
  cleandata = data?.messages?.[0]?.content;

  const lat = req.body.lat;
  const long = req.body.long;
  let address;
  if (lat && long) {
    address = await calculateAddress(lat, long);
  } else {
    address = "";
  }

  if (transcriptionText === "burn") {
    call(address);
    res.json({ message: "Contacted Emergency Services", transcript: transcriptionText, data: cleandata });
  } else {
    res.json({ message: "Transcript received", transcript: transcriptionText, address: address, data: cleandata });
  }
});



async function waitForResponse(message) {
  var params = {
    botId: process.env.BOT_ID,
    botAliasId: process.env.BOT_ALIAS_ID,
    localeId: "en_US",
    sessionId: process.env.SESSION_ID,
    text: message,
  };
  try {
    const data = await new Promise((resolve, reject) => lexruntime.send(new RecognizeTextCommand(params), (err, data) => {
      if (err) {
        reject(err);
      } else {
        resolve(data);
      }
    }));
    return data;
  } catch (err) {
    console.log(err, err.stack);
  }
}

async function call(address){
  await client.calls.create({
    twiml: `<Response><Say>Someone is burned, we need an ambulance as soon as possible, the incident is at ${address}</Say></Response>`,
    to: '+14372555840',
    from: '+18285200175'
  })
}

async function calculateAddress(lat, long) {
  try {
    const response = await fetch(
      `https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${lat}&lon=${long}`
    );
    const json = await response.json();
    return json.display_name.split(",").slice(0, 5).join(" ");
  } catch (error) {
    console.error(error);
    return "Error: Unable to fetch address";
  }
}

app.use((req, res, next) => {
  res.status(404).send("404 - Not Found");
});

const PORT = 8080;
server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

module.exports = app;
