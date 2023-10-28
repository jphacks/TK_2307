/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

import { CreatePingController } from "./controller/health/CreatePingController";
import { GetPingController } from "./controller/health/GetPingController";
import { CreateSpotController } from "./controller/spot/CreateSpotController";
import { GetSpotsByLocationController } from "./controller/spot/GetSpotsByLocationController";

exports.createPing = functions.https.onRequest(CreatePingController);
exports.getPing = functions.https.onRequest(GetPingController);
exports.createSpot = functions.https.onRequest(CreateSpotController);
exports.getSpotsByLocation = functions.https.onRequest(
  GetSpotsByLocationController
);

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
