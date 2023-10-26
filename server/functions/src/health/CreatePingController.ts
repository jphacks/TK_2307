import * as admin from "firebase-admin";
import * as express from "express";
import * as cors from "cors";
import { PingModel } from "./PingModel";

export const CreatePingController = express();
CreatePingController.use(cors({ origin: true }));

CreatePingController.post("/", async (req, res) => {
  res.set("Access-Control-Allow-Headers", "*");
  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Methods", "GET, HEAD, OPTIONS, POST");

  const pingsCollectionRef = admin.firestore().collection("pings");
  const addPingResult = await pingsCollectionRef.add({
    ping: req.body.ping,
  });

  const createdPing: PingModel = {
    pingId: addPingResult.id,
    ping: req.body.ping,
  };

  res.json({ createdPing: createdPing });
});
