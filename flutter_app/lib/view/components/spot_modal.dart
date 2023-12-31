import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/post_spot_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SpotModal extends StatefulWidget {
  final PostSpotResponse spotData;
  const SpotModal({super.key, required this.spotData});

  @override
  _SpotModalState createState() => _SpotModalState();
}

class _SpotModalState extends State<SpotModal> {
  Image? _imageData;

  // UIのラベル文字列
  final seasonOptions = ["春", "夏", "秋", "冬"];
  final historyOptions = ["最近", "少し前", "ずっと昔"];
  final timeOptions = ["昼間", "夕方", "夜"];

  @override
  void initState() {
    super.initState();
    getImageFromCloudStrage();
  }

  void getImageFromCloudStrage() async {
    print(widget.spotData.spotDocumentId);
    final imageRef = FirebaseStorage.instance
        .ref()
        .child("images")
        .child("${widget.spotData.spotDocumentId}.jpg");

    try {
      final Uint8List? data = await imageRef.getData();
      setState(() {
        _imageData = Image.memory(data!);
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 450,
      child: SingleChildScrollView(
        child: Column(children: [
          if (_imageData != null) _imageData!,
          SizedBox(height: 5),
          Text(
            widget.spotData.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24, // フォントサイズを適宜調整
            ),
          ),
          Text(
            '年代：${historyOptions[widget.spotData.history.index]}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14, // フォントサイズを適宜調整
            ),
          ),
          SizedBox(height: 3),
          Text(
            '季節：${seasonOptions[widget.spotData.season.index]}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14, // フォントサイズを適宜調整
            ),
          ),
          SizedBox(height: 3),
          Text(
            '時間：${timeOptions[widget.spotData.time.index]}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14, // フォントサイズを適宜調整
            ),
          ),
        ]),
      ),
    );
  }
}
