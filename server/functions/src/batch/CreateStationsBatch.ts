import * as admin from "firebase-admin";
import * as fs from "fs";
import * as path from "path";
import { StationModel } from "../model/spot/StationModel";

// ./node_modules/.bin/ts-node-esm src/batch/CreateStationsBatch.ts
// https://qiita.com/nyanchu/items/0b5ac293765edf97577e

interface Feature {
  type: string;
  properties: {
    N02_005: string;
  };
  geometry: {
    type: string;
    coordinates: number[][];
  };
}

interface GeoJSON {
  type: string;
  name: string;
  features: Feature[];
}

// const serviceAccountPath = path.join(__dirname, "./secret-key.json");
// const serviceAccount = JSON.parse(fs.readFileSync(serviceAccountPath, "utf8"));
// admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
// });
// console.log("Connected to Firebase");

admin.firestore().settings({
  host: "localhost:8080",
  ssl: false,
});

const stationsCollectionRef = admin.firestore().collection("stations");
console.log("Connected to Firestore");

const filePath = path.join(__dirname, "./data/N02-22_Station.geojson");
const rawData = fs.readFileSync(filePath, "utf8");
const geoJSONData: GeoJSON = JSON.parse(rawData);
console.log("Loaded GeoJSON data");

const insertData = async () => {
  let batch = admin.firestore().batch();
  let count = 0;

  for (const feature of geoJSONData.features) {
    const stationModel: StationModel = {
      name: feature.properties.N02_005,
      latitude: feature.geometry.coordinates[0][1],
      longitude: feature.geometry.coordinates[0][0],
    };

    const querySnapshot = await stationsCollectionRef
      .where("name", "==", stationModel.name)
      .where("latitude", "==", stationModel.latitude)
      .where("longitude", "==", stationModel.longitude)
      .get();

    if (querySnapshot.empty) {
      const docRef = stationsCollectionRef.doc();
      batch.set(docRef, stationModel);
      count++;

      if (count >= 500) {
        console.log("Committing batch...");
        await batch.commit();
        batch = admin.firestore().batch();
        count = 0;
      }
    } else {
      console.log(`Skipped (already exists): ${stationModel.name}`);
    }
  }

  if (count > 0) {
    console.log("Committing final batch...");
    await batch.commit();
  }
};

insertData().catch((error) => {
  console.error("Failed to insert data:", error);
});
