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

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1AB67F),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 150),
            ElevatedButton(
              child: const Text(
                '近くの車窓を見る',
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
                fixedSize: Size(300, 60),
              ),
              onPressed: () {},
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text(
                '自分の投稿を見る',
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
                fixedSize: Size(300, 60),
              ),
              onPressed: () {},
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text(
                'おすすめの車窓を見る',
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
                fixedSize: Size(300, 60),
              ),
              onPressed: () {},
            ),
            SizedBox(height: 60),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: Text(
                  '設定',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            CupertinoSwitchTile(
              title: '近くの車窓通知',
              value: true, // 任意の初期値を設定
              onChanged: (newValue) {
                // スイッチの状態が変わったときの処理を書く
              },
            ),
            CupertinoSwitchTile(
              title: '乗り過ごし防止通知',
              value: true, // 任意の初期値を設定
              onChanged: (newValue) {
                // スイッチの状態が変わったときの処理を書く
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 60, vertical: 25),
              child: CupertinoTextField(
                placeholder: '降りる予定の駅を入力',
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                onChanged: (text) {
                  // テキストが変更されたときの処理を書く
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
