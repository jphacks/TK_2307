import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final Function() loginHandler;
  const LoginPage({super.key, required this.loginHandler});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 入力したメールアドレス・パスワード
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.person, size: 100, color: Color(0xFF131111)),
                SizedBox(height: 10),
                // 1行目 メールアドレス入力用テキストフィールド
                Container(
                  width: 250, // テキストフィールドの幅を指定
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'メールアドレス',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green, // アクティブ時のボーダーカラーを設定
                        ),
                      ),
                    ),
                    cursorColor: Colors.green,
                    onChanged: (String value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                // 2行目 パスワード入力用テキストフィールド
                Container(
                  width: 250, // テキストフィールドの幅を指定
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'パスワード',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green, // アクティブ時のボーダーカラーを設定
                        ),
                      ),
                    ),
                    obscureText: true,
                    onChanged: (String value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 40),

                // 3行目 ユーザ登録ボタン
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // 角の丸みを指定
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Colors.green), // ボタンの背景色を青色に設定
                    minimumSize: MaterialStateProperty.all(
                        Size(150, 50)), // ボタンの最小サイズを設定
                  ),
                  child: Text(
                    'ユーザ登録',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // テキストの太さを太字に設定
                      fontSize: 16, // テキストのサイズを指定
                    ),
                  ),
                  onPressed: () async {
                    try {
                      final User? user = (await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _email, password: _password))
                          .user;
                      if (user != null)
                        print("ユーザ登録しました ${user.email} , ${user.uid}");
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                SizedBox(height: 20),

                // 4行目 ログインボタン
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // 角の丸みを指定
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Colors.green), // ボタンの背景色を緑色に設定
                    minimumSize: MaterialStateProperty.all(
                        Size(150, 50)), // ボタンの最小サイズを設定
                  ),
                  child: Text(
                    'ログイン',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // テキストの太さを太字に設定
                      fontSize: 16, // テキストのサイズを指定
                    ),
                  ),
                  onPressed: () async {
                    try {
                      // メール/パスワードでログイン
                      final User? user = (await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email, password: _password))
                          .user;
                      if (user != null) {
                        print("ログインしました　${user.email} , ${user.uid}");
                        widget.loginHandler();
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _onCheck() {
  print(FirebaseAuth.instance.currentUser);
}
