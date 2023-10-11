import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksij_kinshasa/pages/accueil.dart';

class Splash extends StatelessWidget {
  Splash() {
    Timer(const Duration(seconds: 2), () {
      Get.offAll(Accueil());
    });
  }
  @override
  Widget build(BuildContext context) {
    //
    return const Scaffold(
      body: Center(
        child: Text("Ksij Kinshasa"),
      ),
    );
  }
}
