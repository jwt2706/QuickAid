const express = require("express");
const cors = require("cors");
const axios = require("axios");
const http = require("http");
const app = express();
const server = http.createServer(app);
const io = require("socket.io")(server);
const conditions = [
  "heart attack",
  "stroke",
  "first degree burn",
  "second degree burn",
  "third degree burn",
  "burn",
  "nose bleed",
  "seizure",
  "choking",
  "fainted not breathing",
  "fainted",
  "broken bone",
  "sprained ankle",
  "concussion",
  "cut",
  "big cut",
  "bleeding internally",
  "internal bleeding",
  "bleeding",
  "stabbed",
  "stab",
  "bitten",
  "asthma",
  "hypothermia",
  "freezing",
  "really cold",
  "heatstroke",
  "really hot",
  "sunstroke",
  "snake bite",
  "bitten by snake",
  "severe bleeding",
  "electric shock",
  "electrocuted",
  "drowning",
  "drowned",
  "allergy",
  "cpr",
];
app.use(cors());
app.use(express.json());
require("dotenv").config();
var client = require("twilio")(
  process.env.TWILIO_ACCOUNT_SID,
  process.env.TWILIO_TOKEN
);

async function call(address, condition, extraText) {
  if (extraText) {
    condition = "is having a " + condition;
  } else {
    condition = "has a " + condition;
  }
  await client.calls.create({
    twiml: `<Response><Say>Someone ${condition}, we need an ambulance as soon as possible, the incident is located at: ${address}</Say></Response>`,
    to: "+14372555840",
    from: "+18285200175",
  });
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

function findWords(sentence, wordList) {
  let pattern = wordList.join("|");
  let regex = new RegExp(pattern, "gi");
  let matches = sentence.match(regex);
  return matches;
}

async function contactEmergency(address, condition) {
  const postData = {
    condition: condition,
    extraText: true,
    address: address,
  };

  try {
    await axios.get("https://quickaid-server.vercel.app/contact", postData);
    console.log("Emergency contact susful");
  } catch (error) {
    console.error("Error contacting emergency services:", error);
  }
}

app.get("/contact", async (req, res) => {
  if (req.extraText) {
    req.condition = "is having a " + req.condition;
  } else {
    req.condition = "has a " + req.condition;
  }
  await client.calls.create({
    twiml: `<Response><Say>Someone ${req.condition}, we need an ambulance as soon as possible, the incident is located at: ${req.address}</Say></Response>`,
    to: "+14372555840",
    from: "+18285200175",
  });
  console.log("called");
  res.send("Success");
});

app.post(
  "/transcript",
  async (req, res) => {
    const transcript = req.body.transcript;
    const condition = findWords(transcript.toLowerCase(), conditions);
    const lat = req.body.lat;
    const long = req.body.long;
    let address;
    if (lat && long) {
      address = await calculateAddress(lat, long);
    } else {
      address = "";
    }

    const conditionVariable = condition
      ? condition.toString().toLowerCase()
      : "";
    let isEmergency = false;
    let instructions = "";
    let extraText = false;
    switch (conditionVariable) {
      case "heart attack":
        instructions =
          "Ensure calmness through deep breaths.Consume Aspirin if needed. Consume  nitroglycerin, if needed. If previous heart condition, take prescribed medication. Emergency Services have been contacted.";
        isEmergency = true;
        extraText = true;
        break;
      case "stroke":
        instructions =
          "If someone is having a stroke, recognize the signs using FAST (Face drooping, Arm weakness, Speech difficulty, Time to call emergency). Stay with the person, keep them calm, and do not give them anything to eat or drink. Emergency Services have been contacted.";
        extraText = true;
        await contactEmergency(address, condition);
        break;
      case "first degree burn":
        instructions =
          "Run cool water over the area for 3-5 minutes. Take an over-the-counter pain reliever. Apply an antibiotic ointment. Cover the burn with a sterile bandage.";
        extraText = true;
        break;
      case "second degree burn":
        instructions =
          "Run cool water over the area for 3-5 minutes. Take an over-the-counter pain reliever. Apply an antibiotic ointment. Cover the burn with a sterile bandage. Emergency Services have been contacted.";
        extraText = true;
        await contactEmergency(address, condition);
        break;
      case "third degree burn":
        instructions =
          "Do NOT apply water, ointments, or ice. Cover the burn with a sterile bandage. Emergency Services have been contacted.";
        extraText = true;
        await contactEmergency(address, condition);
        break;
      case "burn":
        instructions =
          "Run cool water over the area for 3-5 minutes. Take an over-the-counter pain reliever. Apply an antibiotic ointment. Cover the burn with a sterile bandage.";
        extraText = true;
        break;
      case "nose bleed":
        instructions =
          "Sit down and lean forward. Pinch the nose and breathe through the mouth. Apply an ice pack to the nose. If the bleeding doesn't stop after 20 minutes, call emergency services.";
        extraText = true;
        break;
      case "bloody nose":
        instructions =
          "Sit down and lean forward. Pinch the nose and breathe through the mouth. Apply an ice pack to the nose. If the bleeding doesn't stop after 20 minutes, call emergency services.";
        extraText = true;
        break;
      case "seizure":
        instructions =
          "Move any nearby objects away from the person. Place the person on their side after the seizure ends. Stay with the person until they are fully alert. Emergency Services have been contacted.";
        extraText = true;
        await contactEmergency(address, condition);
        break;
      case "seizing":
        instructions =
          "Move any nearby objects away from the person. Place the person on their side after the seizure ends. Stay with the person until they are fully alert. Emergency Services have been contacted.";
        extraText = true;
        await contactEmergency(address, condition);
        break;
      case "choking":
        instructions =
          "Perform the Heimlich maneuver (abdominal thrusts from back). If the person is unable to breathe, call emergency services.";
          await contactEmergency(address, condition);
        break;
      case "fainted not breathing":
        instructions =
          "Lay the person on their back and elevate their legs. Emergency services have been contacted.";
          await contactEmergency(address, condition);
        break;
      case "fainted":
        instructions =
          "Lay the person on their back and elevate their legs. If the person is not breathing, call emergency services.";
        break;
      case "broken bone":
        instructions =
          "Immobilize the injured area. Apply ice to the injured area. Emergency Services have been contacted.";
          extraText = true;
          await contactEmergency(address, condition);
        break;
      case "sprained ankle":
        instructions =
          "Rest the ankle. Ice the ankle. Compress the ankle. Elevate the ankle.";
        extraText = true;
        break;
      case "not breathing":
        instructions =
          "If no pulse, perform CPR immediately, emergency services called";
          await contactEmergency(address, condition);
          break;
      case "cpr":
        instructions =
          "Make sure there is no heartbeat, Give 30 chest compressions, arms aligned at the center of the chest horizontally to the persons armits, give 2 breaths, repeat cycle";
        break;
      case "concussion":
        instructions =
          "Treatment: Rest and avoid physical activity. Apply ice to the injured area. Emergency Services have been contacted.";
          await contactEmergency(address, condition);
          extraText = true;
        break;
      case "head injury":
        instructions =
          "Treatment: Rest and avoid physical activity. Apply ice to the injured area. Emergency Services have been contacted.";
          await contactEmergency(address, condition);
          break;
      case "cut":
        instructions =
          "Apply pressure to the cut with a clean cloth. If the bleeding doesn't stop after 20 minutes, call emergency services.";
        extraText = true;
        break;
      case "big cut":
        instructions =
          "Apply pressure to the cut with a clean cloth. Do not remove the cloth. Continue to add more cloths if needed. Emergency Services have been contacted.";
        extraText = true;
        await contactEmergency(address, condition);
        break;
      case "bleeding internally":
        instructions =
          "Lay the person on their back and elevate their legs. Emergency Services have been contacted.";
          await contactEmergency(address, condition);
          break;
      case "internal bleeding":
        instructions =
          "Lay the person on their back and elevate their legs. Emergency Services have been contacted.";
          await contactEmergency(address, condition);
          break;
      case "bleeding":
        instructions =
          "Apply pressure to the cut with a clean cloth. If the bleeding doesn't stop after 20 minutes, call emergency services.";
        break;
      case "stabbed":
        instructions =
          "Apply direct pressure to control bleeding, emergency services have been contacted";
          await contactEmergency(address, condition);
          break;
      case "stab":
        instructions =
          "Apply direct pressure to control bleeding, emergency services have been contacted";
          await contactEmergency(address, condition);
          break;
      case "bitten":
        instructions =
          "Clean the wound with soap and water, apply an antibiotic ointment, cover with a sterile bandage,seek medical attention to prevent infection and evaluate for rabies";
        break;
      case "asthma":
        instructions =
          "administer a rescue inhaler (e.g., albuterol), assist with using a spacer if available, help the person sit upright and breathe slowly, call emergency services if symptoms worsen.";
        break;
      case "hypothermia":
        instructions =
          "Gradually warm the person, remove wet clothing if necessary, cover with blankets or warm clothing, provide/consume warm drinks, seek medical help.";
        break;
      case "freezing":
        instructions =
          "Gradually warm the person, remove wet clothing if necessary, cover with blankets or warm clothing, provide/consume warm drinks, seek medical help.";
        break;
      case "really cold":
        instructions =
          "Gradually warm the person, remove wet clothing if necessary, cover with blankets or warm clothing, provide/consume warm drinks, seek medical help.";
        break;
      case "heatstroke":
        instructions =
          "Move to a cooler place, remove excess clothing, apply cool compresses or immerse in cool water, fan, offer/consume fluids if conscious, seek medical help.";
        break;
      case "really hot":
        instructions =
          "Move to a cooler place, remove excess clothing, apply cool compresses or immerse in cool water, fan, offer/consume fluids if conscious, seek medical help.";
        break;
      case "sunstroke":
        instructions =
          "Move to a cooler place, remove excess clothing, apply cool compresses or immerse in cool water, fan, offer/consume fluids if conscious, seek medical help.";
        break;

      case "snake bite":
        instructions =
          "Keep the affected limb immobilized below heart level, remove tight clothing or jewelry, clean the wound, apply a sterile bandage, emergency services have been called.";
          await contactEmergency(address, condition);
          break;
      case "bitten by snake":
        instructions =
          "Keep the affected limb immobilized below heart level, remove tight clothing or jewelry, clean the wound, apply a sterile bandage, emergency services have been called.";
          await contactEmergency(address, condition);
          break;
      case "severe bleeding":
        instructions =
          "Keep the affected limb immobilized below heart level, remove tight clothing or jewelry, clean the wound, apply a sterile bandage, emergency services have been called";
          await contactEmergency(address, condition);
          break;
      case "electric shock":
        instructions =
          "Ensure safety from the electrical source, perform CPR if necessary, emergency services called.";
          await contactEmergency(address, condition);
          break;
      case "electrocuted":
        instructions =
          "Ensure safety from the electrical source, perform CPR if necessary, emergency services called.";
          await contactEmergency(address, condition);
          break;
      case "drowning":
        instructions = "Preform CPR, emergency services have been called ";
        await contactEmergency(address, condition);
        break;
      case "drowned":
        instructions = "Preform CPR, emergency services have been called ";
        await contactEmergency(address, condition);
        break;
      case "allergy":
        instructions =
          "Administer epinephrine (EpiPen), emergency services called";
          await contactEmergency(address, condition);
          break;
      default:
        instructions = "I did not understand. Can you please explain again?";
        break;
    }
    res.json({ message: instructions, transcript: transcript });
    
  },
  (error, req, res, next) => {
    console.error(error);
    //res.status(500).json({ message: "Error processing transcript: " + error });
  }
);
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

app.use((req, res, next) => {
  res.status(404).send("404 - Not Found");
});

const PORT = 8080;
server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

module.exports = app;
