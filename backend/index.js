const express = require("express");
const cors = require("cors");
const axios = require("axios");

const app = express();
app.use(cors());
app.use(express.json());

require("dotenv").config();

<<<<<<< HEAD





=======
>>>>>>> contacts-page
var client = require("twilio")(
  process.env.TWILIO_ACCOUNT_SID,
  process.env.TWILIO_TOKEN
);

app.post("/transcription", (req, res) => {
  const transcriptionText = req.body.TranscriptionText;
  console.log("Transcription:", transcriptionText);
  // Handle the transcription text as needed
  res.status(200).json({ transcription: transcriptionText });
});

async function call(location, injury) {
  await client.calls.create({
    twiml: `<Response><Say>There is an emergency, we need an ambulance, it is a ${injury} at ${location}</Say></Response>`,
    to: "+14372555840",
    from: "+18285200175",
  });
}

app.get("/", (req, res) => {
  res.send("Hello, world!");
});

app.get("/contact", (req, res) => {
  res.send("Contact page");
});

app.get("/user/:id", (req, res) => {
  const userId = req.params.id;
  res.send(`User ID: ${userId}`);
});

app.post("/transcript", async (req, res) => {
  const transcript = req.body.transcript;
  const lat = req.body.lat
  const long = req.body.long
  console.log("Received transcript:", transcript);
  if (transcript === "burn") {
    call("Ottawa", "third degree burn");
    // try {
    //   const response = await axios.post("http://localhost:8080/gif", {
    //     transcript: "burn",
    //   });
    //   const gifUrl = response.data.message;
    //   res.json({
    //     message: "Transcript received",
    //     transcript: transcript,
    //     image: gifUrl,
    //   });
    // } catch (error) {
    //   console.error("Error fetching GIF:", error);
    //   res.status(500).json({ message: "Error fetching GIF" });
    // }
  } else {
    res.json({ message: "Transcript received", transcript: transcript,lat: lat, long:long });

  }
});

app.post("/gif", (req, res) => {
  if (req.body.transcript === "burn") {
    res.json({
      message:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_WF_JjUjuToNWN3WCU0f3RqFy3qDfhQTDnQ&usqp=CAU",
      transcript: req.body.transcript,
    });
  }
});

app.use((req, res, next) => {
  res.status(404).send("404 - Not Found");
});

const PORT = 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
