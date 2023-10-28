import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CupertinoSwitchTile extends StatelessWidget {
  const CupertinoSwitchTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title; // titleの型をStringに変更
  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 70.0),
      leading: null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          )
        ],
      ),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class SharePage extends StatelessWidget {
  const SharePage({Key? key});

  // モーダル内のコンテンツを表示するウィジェット
  Widget _buildModalContent(BuildContext context) {
    return Container(
        // モーダルの内容をここに追加
        );
  }

  // ボタンを押した際にモーダルを表示する関数
  void _showModal(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      context: context,
      builder: (BuildContext context) {
        return _buildModalContent(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1AB67F),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: Text(
                  'すれちがい通信',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            CupertinoSwitchTile(
              title: 'すれちがい通信',
              value: true, // 任意の初期値を設定
              onChanged: (newValue) {
                // スイッチの状態が変わったときの処理を書く
              },
            ),
            SizedBox(height: 25),
            ElevatedButton(
              child: const Text(
                'お気に入りの車窓を登録する',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Color(0xFF131111),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fixedSize: Size(250, 60),
              ),
              onPressed: () {
                _showModal(context);
              }, // ボタンを押した際にモーダルを表示},
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Text(
                  '(お気に入りの車窓はすれちがい通信で共有されます。)',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(height: 70),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 75.0),
                child: Text(
                  'これまでのすれちがい人数',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 150.0),
                child: Text(
                  '?人',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Text(
                  'みんなのお気に入り',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            // card
            Container(
              height: 100,
              width: 300,
              child: Card(
                child: Column(
                  children: const [
                    ListTile(
                      title: Text('場所名'),
                      subtitle: Text('説明'),
                    ),
                  ],
                ),
                color: Colors.white,
                elevation: 8,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              margin: const EdgeInsets.all(30),
            )
          ],
        ),
      ),
    );
  }
}
