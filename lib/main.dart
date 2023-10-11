import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksij_kinshasa/pages/splash.dart';

void main() {
  runApp(const ksij());
}

class ksij extends StatelessWidget {
  const ksij({super.key});
  //
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ksij Kinshasa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}
