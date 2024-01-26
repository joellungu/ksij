import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';
//import 'package:permission_handler/permission_handler.dart';

class Mecque extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //
    return _Mecque();
  }
}

class _Mecque extends State<Mecque> {
  bool _hasPermissions = false;
  CompassEvent? _lastRead;
  DateTime? _lastReadAt;
  //

  @override
  void initState() {
    //
    getLocation();
    //
    super.initState();
  }

  //
  getLocation() async {
    //
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      //Permission.storage,
    ].request();
    print(statuses[Permission.location]);
    //
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      // Use location.
      print("Geo localisation Yes...");
    } else {
      print("Not Not Geo localisation Yes...");
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text('Mecque'),
      // ),
      body: Center(
        child: SmoothCompass(
          isQiblahCompass: true,
          //higher the value of rotation speed slower the rotation
          rotationSpeed: 500,
          height: 300,
          width: 300,
        ),
      ),
    );
  }

  //
}
