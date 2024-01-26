import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksij_kinshasa/main.dart';
import 'package:ksij_kinshasa/pages/accueil.dart';
import 'package:ksij_kinshasa/utils/local_notification_service.dart';

import 'calendrier/calendrier_controller.dart';
import 'home/evenements/details_evenement.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //
    return _Splash();
    //
  }
}

class _Splash extends State<Splash> {
  //
  CalendrierController calendrierController = Get.find();
  //

  //
  String? _token;
  String? initialMessage;
  bool _resolved = false;

  //
  @override
  void initState() {
    super.initState();
    //
    getCalendier();
    //

    // FirebaseMessaging.instance.getInitialMessage().then(
    //       (value) => setState(
    //         () {
    //           _resolved = true;
    //           initialMessage = value?.data.toString();
    //         },
    //       ),
    //     );

    // FirebaseMessaging.onMessage.listen((data) {
    //   //
    //   print("Data rec: _____________________________");
    //   print("Data rec: ${data.category}");
    //   print("Data rec: _____________________________");
    //   print("Data rec: ${data.messageId}");
    //   print("Data rec: _____________________________");
    //   print("Data rec: ${data.messageType}");
    //   print("Data rec: _____________________________");
    //   print("Data rec: ${data.notification!.title}");
    //   print("Data rec: _____________________________");
    //   print("Data rec: ${data.notification!.body}");
    //   print("Data rec: _____________________________");
    //   print("Data rec: ${data.data}");
    //   print("Data rec: _____________________________&&&&&&");
    //   //
    //   //appController.givePosition();
    //   //
    //   showFlutterNotification(data);
    //   //
    // });

    //
    // FirebaseMessaging.onBackgroundMessage(
    //   (RemoteMessage message) {
    //     print('A new onMessageOpenedApp event was published!');
    //     //
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: ((context) {
    //           return DetailsEvenement(message.data);
    //         }),
    //       ),
    //     );
    //     return ;
    //   },
    // );

    //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //     print('A new onMessageOpenedApp event was published!');
    //     //Get.to();
    //     Get.to(DetailsEvenement(message.data));
    //     // Navigator.push(
    //     //   context,
    //     //   MaterialPageRoute(
    //     //     builder: ((context) {
    //     //       return DetailsEvenement(message.data);
    //     //     }),
    //     //   ),
    //     // );
    //   });
  }

  //
  getCalendier() async {
    Map<String, dynamic> e = {};
    //
    e["id"] = "123KKL";
    e["titre"] = "Un titre et tout";
    e["contenu"] = "vijdnsdj bjk dsb ldvsljd sljdsg lu";
    e["auteur"] = "vdkjn ovd";
    e["dateTime"] = "25-1-2024";
    e["sousTitre"] = "Sous titre";
    e["asPhoto"] = "false";
    //
    RemoteMessage remoteMessage = RemoteMessage(
      senderId: "II2",
      notification: RemoteNotification(
        title: "Salut",
        body: "Comment ?",
      ),
      data: e,
    );
    //LocalNotificationService.rappel(remoteMessage);
    bool v = await calendrierController.getAllDate();
    if (v) {
      //router.pushNamed("accueil");
      Get.offAll(Accueil());
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return const Scaffold(
      body: Center(
        child: Text("KSIJ KINSHASA"),
      ),
    );
  }
}
