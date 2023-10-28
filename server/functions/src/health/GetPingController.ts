import * as admin from "firebase-admin";
import * as express from "express";
import * as cors from "cors";
import { PingModel } from "./PingModel";

export const GetPingController = express();
GetPingController.use(cors({ origin: true }));

GetPingController.get("/", async (req, res) => {
  res.set("Access-Control-Allow-Headers", "*");
  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Methods", "GET, HEAD, OPTIONS, POST");

  const pingsCollectionRef = admin.firestore().collection("pings");
  const pings = await pingsCollectionRef.get();

  var responseData: any[] = [];
  pings.forEach((item) => {
    var ping: PingModel = {
      pingId: item.id,
      ping: item.get("ping"),
    };
    responseData.push(ping);
  });

  if (responseData.length != 0) {
    res.json({ pings: responseData });
  } else {
    res.status(404).send("グループがありません");
  }
});
