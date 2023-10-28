import * as admin from "firebase-admin";
import * as express from "express";
import * as cors from "cors";
import { LocationModel } from "../../model/spot/LocationModel";
import { StationModel } from "../../model/spot/StationModel";
import { SpotModel } from "../../model/spot/SpotModel";

export const GetSpotsByLocationController = express();
GetSpotsByLocationController.use(cors({ origin: true }));

GetSpotsByLocationController.post("/", async (req, res) => {
  res.set("Access-Control-Allow-Headers", "*");
  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Methods", "GET, HEAD, OPTIONS, POST");

  const spotsCollectionRef = admin.firestore().collection("spots");

  const location: LocationModel = {
    latitude: req.body.latitude,
    longitude: req.body.longitude,
  };

  const nearestStationDocumentId = await getNearestStationDocumentId(location);
  console.log(nearestStationDocumentId);
  const spots = await spotsCollectionRef
    .where("stationDocumentId", "==", nearestStationDocumentId)
    .get();

  var responseData: any[] = [];
  spots.forEach((doc) => {
    const data = doc.data() as SpotModel;
    responseData.push(data);
  });

  res.json({ spots: responseData });
});

export async function getNearestStationDocumentId(
  location: LocationModel
): Promise<string> {
  const stationsCollectionRef = admin.firestore().collection("stations");
  const stations = await stationsCollectionRef.get();

  let nearestDocumentId: string = "";
  let nearestDistance: number = Infinity;

  stations.forEach((doc) => {
    const data = doc.data() as StationModel;
    const distance = calculateDistance(location, data);

    if (distance < nearestDistance) {
      nearestDistance = distance;
      nearestDocumentId = doc.id;
    }
  });

  return nearestDocumentId;
}

function calculateDistance(a: LocationModel, b: StationModel): number {
  return Math.sqrt(
    Math.pow(a.latitude - b.latitude, 2) +
      Math.pow(a.longitude - b.longitude, 2)
  );
}
