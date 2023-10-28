import 'package:flutter/material.dart';
import 'package:flutter_app/model/post_spot_model.dart';
import 'package:flutter_app/util/http_client.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';

class PostSpotModal extends StatefulWidget {
  const PostSpotModal({super.key});

  @override
  _PostSpotModalState createState() => _PostSpotModalState();
}

class _PostSpotModalState extends State<PostSpotModal> {
  late PostSpotRequest postSpotRequest;
  Position? currentPos;
  late StreamSubscription<Position> positionStream;
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high, //正確性:highはAndroid(0-100m),iOS(10m)
    distanceFilter: 100,
  );

  void initState() {
    super.initState();

    //現在位置を更新し続ける
    positionStream =
      Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      if(position != null) {
        currentPos = position;
        postSpotRequest.lat = position.latitude;
        postSpotRequest.lng = position.longitude;
      }
    });
  }

  Future<Position?> _future() async {
    currentPos = await Geolocator.getCurrentPosition();
    return currentPos;
  }

  @override
  Widget build(BuildContext context) {
    postSpotRequest = PostSpotRequest(
      season: SeasonEnum.spring,
      history: HistoryEnum.recent,
      time: TimeEnum.daytime,
      userId: "aaaaa"
    );

    return (
      Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("地点名"),
            Text("季節"),
            Text("年代"),
            Text("時間帯"),
            ElevatedButton(
              onPressed: () async {
                final res = await execPostRequestWithParam("/CreateSpot", postSpotRequest.convert2map());
                print(res.body);
                Navigator.of(context).pop();
              },
              child: const Text("投稿"),
            )
          ],
        )
      )
    );
  }
}