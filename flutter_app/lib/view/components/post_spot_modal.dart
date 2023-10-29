import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/post_spot_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

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

  XFile? _image;
  final imagePicker = ImagePicker();

  // ギャラリーから写真を取得するメソッド
  Future getImageFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = XFile(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Column(
          children: [
            // 画像の選択
            _image == null
                ? ElevatedButton(
                    onPressed: getImageFromGallery,
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF1AB67F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      minimumSize: Size(90, 40),
                    ),
                    child: Text(
                      '写真を選択してください',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white, fontSize: 14),
                    ),
                  )
                : Image.file(File(_image!.path)),

            // 地点名の入力
            Container(
              width: MediaQuery.of(context).size.width * 0.8, // 画面幅の80%に設定
              padding: const EdgeInsets.all(20),
              child: TextField(
                enabled: true,
                onChanged: _handleSpotNameInput,
                decoration: const InputDecoration(
                  labelText: "地点名を入力",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green), // 下線の色を指定
                  ),
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                cursorColor: Colors.green, // カーソルの色を指定
              ),
            ),

            // 季節の選択
            Row(
              children: [
                for (int i = 0; i < seasonOptions.length; i++) ...{
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0), // 左側に空白を追加（必要に応じて調整）
                    child: Row(
                      children: [
                        Radio(
                          value: i,
                          groupValue: _selectedSeason,
                          activeColor: Color(0xFF1AB67F),
                          onChanged: (value) {
                            setState(() {
                              _selectedSeason = value!;
                            });
                          },
                        ),
                        Text(seasonOptions[i]),
                      ],
                    ),
                  ),
                }
              ],
            ),

            // 年代の選択
            Row(
              children: [
                for (int i = 0; i < historyOptions.length; i++) ...{
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0), // 左側に空白を追加（必要に応じて調整）
                    child: Row(
                      children: [
                        Radio(
                          value: i,
                          groupValue: _selectedHistory,
                          activeColor: Color(0xFF1AB67F),
                          onChanged: (value) {
                            setState(() {
                              _selectedHistory = value!;
                            });
                          },
                        ),
                        Text(historyOptions[i]),
                      ],
                    ),
                  ),
                }
              ],
            ),

            // 時間帯の選択
            Row(
              children: [
                for (int i = 0; i < timeOptions.length; i++) ...{
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0), // 左側に空白を追加（必要に応じて調整）
                    child: Row(
                      children: [
                        Radio(
                          value: i,
                          groupValue: _selectedTime,
                          activeColor: Color(0xFF1AB67F),
                          onChanged: (value) {
                            setState(() {
                              _selectedTime = value!;
                            });
                          },
                        ),
                        Text(timeOptions[i]),
                      ],
                    ),
                  ),
                }
              ],
            ),

            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _spotName.isEmpty
                  ? null
                  : () async {
                      final imagesRef =
                          FirebaseStorage.instance.ref().child("images");

                      postSpotRequest = PostSpotRequest(
                        lat: widget.currentPosition!.latitude,
                        lng: widget.currentPosition!.longitude,
                        season: SeasonEnum.values[_selectedSeason],
                        history: HistoryEnum.values[_selectedHistory],
                        time: TimeEnum.values[_selectedTime],
                        name: _spotName,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                      );

                        final res = await execPostRequestWithParam(
                            "/createSpot", postSpotRequest.convert2map());
                        final resObj = jsonDecode(res.body);
                        
                        final fileRef = imagesRef.child("${resObj["spot"]["spotDocumentId"]}.jpg");
                        try {
                          await fileRef.putFile(File(_image!.path));
                        } on FirebaseException catch (e) {
                          print(e);
                        }

                      print(res.body);
                      Navigator.of(context).pop();
                    },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF1AB67F),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // 8.0は角丸の半径（必要に応じて調整）
                ),
                minimumSize: Size(90, 40), // ボタンの最小サイズ（必要に応じて調整）
              ),
              child: const Text("投稿"),
            )
          ],
        ))));
  }
}
