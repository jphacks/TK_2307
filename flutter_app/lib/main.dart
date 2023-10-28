import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import './view/pages/home_page.dart';
import './view/pages/map_page.dart';
import './view/pages/sample_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bottom Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final List<Widget> _pages = [HomePage(), MapPage(), SamplePage()];
  

  @override
  void initState() {
    super.initState();

    //位置情報が許可されていない時に許可をリクエストする
    Future(() async {
      LocationPermission permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){
        await Geolocator.requestPermission();
      }
    });

    _initPermission();
  }

  void _initPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.locationAlways,
    ].request();
    print(statuses[Permission.location]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
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
      ),
    );
  }
}
