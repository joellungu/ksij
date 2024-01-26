import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksij_kinshasa/utils/langi.dart';

class Parametre extends StatelessWidget {
  /**
   *  Maghrib.value = "";
      Sunset.value = "";
      Zuhr.value = "";
      Sunrise.value = "";
      Fajr.value = "";
      Imsak.value = "";
   */

  RxBool evenement = true.obs;
  RxBool nouvel = true.obs;
  RxBool maghrib = true.obs;
  RxBool sunset = true.obs;
  RxBool zuhr = true.obs;
  RxBool sunrise = true.obs;
  RxBool fajr = true.obs;
  RxBool imsak = true.obs;
  //bool evenement = true;
  //
  var box = GetStorage();

  Parametre() {
    //
    //
    evenement.value = box.read('evenement') ?? true;
    if (evenement.value) {
      FirebaseMessaging.instance.subscribeToTopic("evenement");
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic("evenement");
    }
    //

    nouvel.value = box.read('nouvel') ?? true;
    //
    if (nouvel.value) {
      FirebaseMessaging.instance.subscribeToTopic("nouvel");
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic("nouvel");
    }
    //
    //
    maghrib.value = box.read('maghrib') ?? true;
    if (maghrib.value) {
      FirebaseMessaging.instance.subscribeToTopic("maghrib");
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic("maghrib");
    }
    //

    sunset.value = box.read('sunset') ?? true;
    //
    if (sunset.value) {
      FirebaseMessaging.instance.subscribeToTopic("sunset");
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic("sunset");
    }
    //
    //
    zuhr.value = box.read('zuhr') ?? true;
    if (zuhr.value) {
      FirebaseMessaging.instance.subscribeToTopic("zuhr");
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic("zuhr");
    }
    //

    sunrise.value = box.read('sunrise') ?? true;
    //
    if (sunrise.value) {
      FirebaseMessaging.instance.subscribeToTopic("sunrise");
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic("sunrise");
    }
    //
    //
    fajr.value = box.read('fajr') ?? true;
    if (fajr.value) {
      FirebaseMessaging.instance.subscribeToTopic("fajr");
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic("fajr");
    }
    //

    imsak.value = box.read('imsak') ?? true;
    //
    if (imsak.value) {
      FirebaseMessaging.instance.subscribeToTopic("imsak");
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic("imsak");
    }
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Langi.base1,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "What notification do you want to receive",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: const Text(
                  "Evenments",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Switch(
                  onChanged: (e) {
                    //
                    evenement.value = changeAction("evenement");
                  },
                  value: evenement.value,
                ),
              ),
              ListTile(
                title: const Text(
                  "News",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Switch(
                  onChanged: (e) {
                    //
                    nouvel.value = changeAction("nouvel");
                  },
                  value: nouvel.value,
                ),
              ),
              //
              ListTile(
                title: const Text(
                  "Maghrib",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Switch(
                  onChanged: (e) {
                    //
                    maghrib.value = changeAction("maghrib");
                  },
                  value: maghrib.value,
                ),
              ),
              ListTile(
                title: const Text(
                  "Sunset",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Switch(
                  onChanged: (e) {
                    //
                    sunset.value = changeAction("sunset");
                  },
                  value: sunset.value,
                ),
              ),
              ListTile(
                title: const Text(
                  "Zuhr",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Switch(
                  onChanged: (e) {
                    //
                    zuhr.value = changeAction("zuhr");
                  },
                  value: zuhr.value,
                ),
              ),
              ListTile(
                title: const Text(
                  "Sunrise",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Switch(
                  onChanged: (e) {
                    //
                    sunrise.value = changeAction("sunrise");
                  },
                  value: sunrise.value,
                ),
              ),
              ListTile(
                title: const Text(
                  "Fajr",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Switch(
                  onChanged: (e) {
                    //
                    fajr.value = changeAction("fajr");
                  },
                  value: fajr.value,
                ),
              ),
              ListTile(
                title: const Text(
                  "Imsak",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Switch(
                  onChanged: (e) {
                    //
                    imsak.value = changeAction("imsak");
                  },
                  value: imsak.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool changeAction(String topic) {
    var evenement = box.read(topic) ?? true;
    evenement = !evenement;
    box.write(topic, evenement);
    if (evenement) {
      FirebaseMessaging.instance.subscribeToTopic(topic);
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    }
    return evenement;
  }
}
