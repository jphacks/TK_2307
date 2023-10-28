import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/post_spot_model.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';

import '../../util/http_client.dart';

class PostSpotModal extends StatefulWidget {
  final Position? currentPosition;

  const PostSpotModal({super.key, required this.currentPosition});

  @override
  _PostSpotModalState createState() => _PostSpotModalState();
}

class _PostSpotModalState extends State<PostSpotModal> {
  // 投稿フォームの入力値
  String _spotName = "";
  int _selectedSeason = 0;
  int _selectedHistory = 0;
  int _selectedTime = 0;

  // 投稿フォームの選択肢
  final seasonOptions = ["春", "夏", "秋", "冬"];
  final historyOptions = ["最近", "少し前", "ずっと昔"];
  final timeOptions = ["昼間", "夕方", "夜"];

  // リクエスト送信時のオブジェクト
  late PostSpotRequest postSpotRequest;

  void _handleSpotNameInput(String e) {
    setState(() {
      _spotName = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (
      Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 地点名の入力
            TextField(
              enabled: true,
              onChanged: _handleSpotNameInput,
              decoration: const InputDecoration(
                labelText: "地点名"
              ),
            ),

            // 季節の選択
            Row(
              children: [
                for(int i = 0; i < seasonOptions.length; i++) ... {
                  Radio(value: i, groupValue: _selectedSeason, onChanged: (value) {
                    setState(() {
                      _selectedSeason = value!;
                    });
                  }),
                  Text(seasonOptions[i]),
                }
              ]
            ),

            // 年代の選択
            Row(
              children: [
                for(int i = 0; i < historyOptions.length; i++) ... {
                  Radio(value: i, groupValue: _selectedHistory, onChanged: (value) {
                    setState(() {
                      _selectedHistory = value!;
                    });
                  }),
                  Text(historyOptions[i]),
                }
              ]
            ),

            // 時間帯の選択
            Row(
              children: [
                for(int i = 0; i < timeOptions.length; i++) ... {
                  Radio(value: i, groupValue: _selectedTime, onChanged: (value) {
                    setState(() {
                      _selectedTime = value!;
                    });
                  }),
                  Text(timeOptions[i]),
                }
              ]
            ),

            Text("地点名：$_spotName"),
            Text("季節：$_selectedSeason"),
            Text("年代：$_selectedHistory"),
            Text("時間帯：$_selectedTime"),
            ElevatedButton(
              onPressed: _spotName.isEmpty ? null : () async {
                postSpotRequest = PostSpotRequest(
                  lat: widget.currentPosition!.latitude,
                  lng: widget.currentPosition!.longitude,
                  season: SeasonEnum.values[_selectedSeason],
                  history: HistoryEnum.values[_selectedHistory],
                  time: TimeEnum.values[_selectedTime],
                  name: _spotName,
                  userId: "aaaaa"
                );

                final res = await execPostRequestWithParam("/createSpot", postSpotRequest.convert2map());
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