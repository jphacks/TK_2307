import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/view/components/post_spot_modal.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Position? currentPos;
  late StreamSubscription<Position> positionStream;
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(35.6809591, 139.7673068);
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
      currentPos = position;
      print(position == null
        ? 'Unknown'
        : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _showModal() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return PostSpotModal(currentPosition: currentPos,);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0
            )
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: _showModal,
                    child: const Text("押してね")
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}

