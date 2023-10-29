import 'package:flutter/material.dart';
import 'package:flutter_app/view/pages/share_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import './view/pages/home_page.dart';
import './view/pages/map_page.dart';
import 'view/pages/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bottom Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF1AB67F),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool _isLogin = (FirebaseAuth.instance.currentUser != null);
  void loginHandler() {
    setState(() {
      _isLogin = (FirebaseAuth.instance.currentUser != null);
    });
  }

  @override
  void initState() {
    super.initState();

    //位置情報が許可されていない時に許可をリクエストする
    Future(() async {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
    });

    _initPermission();
  }

  void _initPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.locationAlways,
      Permission.photos,
      Permission.camera,
      Permission.microphone,
    ].request();
    print(statuses[Permission.location]);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      const HomePage(),
      const MapPage(),
      LoginPage(
        loginHandler: loginHandler,
      )
    ];

    return Scaffold(
      body: SafeArea(
        child: _isLogin
            ? _pages[_currentIndex]
            : LoginPage(
                loginHandler: loginHandler,
              ),
      ),
      bottomNavigationBar: _isLogin
          ? BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: const Color(0xFF1AB67F),
              // showSelectedLabels: false,
              // showUnselectedLabels: false,
              iconSize: 30,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map),
                  label: 'Map',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.share),
                  label: 'Share',
                ),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            )
          : null,
    );
  }
}
