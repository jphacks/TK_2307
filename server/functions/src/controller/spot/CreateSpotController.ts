import * as admin from "firebase-admin";
import * as express from "express";
import * as cors from "cors";
import { SpotModel } from "../../model/spot/SpotModel";
import { getNearestStationDocumentId } from "./GetSpotsByLocationController";

export const CreateSpotController = express();
CreateSpotController.use(cors({ origin: true }));

CreateSpotController.post("/", async (req, res) => {
  res.set("Access-Control-Allow-Headers", "*");
  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Methods", "GET, HEAD, OPTIONS, POST");

  const spotsCollectionRef = admin.firestore().collection("spots");

  const stationDocumentId = await getNearestStationDocumentId(req.body);
  const addSpotResult = await spotsCollectionRef.add({
    stationDocumentId: stationDocumentId,
    latitude: req.body.latitude,
    longitude: req.body.longitude,
    season: req.body.season,
    history: req.body.history,
    time: req.body.time,
    userId: req.body.userId,
  });

  const createdSpot: SpotModel = {
    spotDocumentId: addSpotResult.id,
    stationDocumentId: stationDocumentId,
    latitude: req.body.latitude,
    longitude: req.body.longitude,
    season: req.body.season,
    history: req.body.history,
    time: req.body.time,
    userId: req.body.userId,
  };

  res.json({ spot: createdSpot });
});
