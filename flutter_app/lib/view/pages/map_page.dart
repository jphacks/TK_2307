import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/post_spot_model.dart';
import 'package:flutter_app/util/http_client.dart';
import 'package:flutter_app/view/components/post_spot_modal.dart';
import 'package:flutter_app/view/components/spot_modal.dart';
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

  List<PostSpotResponse> _spots = [];

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
      _getSpots();
    });

    // スポットの取得
    _getSpots();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _showPostModal() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return PostSpotModal(
          currentPosition: currentPos,
        );
      }
    );
  }

  @override
  void didUpdateWidget(covariant MapPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getSpots();
  }

  void _getSpots() async {
    currentPos = await Geolocator.getCurrentPosition();
    final res = (jsonDecode((await execPostRequestWithParam("/getSpotsByLocation", {"latitude": currentPos!.latitude, "longitude": currentPos!.longitude })).body) as Map)["spots"] as List;

    print(res);

    List<PostSpotResponse> _spotsTemp = [];
    for(int i = 0; i < res.length; i++) {
      _spotsTemp.add(PostSpotResponse.fromJson(res[i]));
    }

    setState(() {
      _spots = _spotsTemp;
    });
  }

  Set<Marker> _createMaker() {
    return {
      for(int i = 0; i < _spots.length; i++) ... {
        Marker(
          markerId: MarkerId(_spots[i].name),
          position: LatLng(_spots[i].latitude, _spots[i].longitude),
          onTap: () {
            showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SpotModal(spotData: _spots[i]);
            });
          },
        )
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            markers: _createMaker(),
            initialCameraPosition: CameraPosition(target: _center, zoom: 11.0)),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: _showPostModal,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF1AB67F),
                    minimumSize: Size(130, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "投稿する",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold, // 文字を太字にする
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
