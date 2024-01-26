//import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ksij_kinshasa/pages/contacts/contacts.dart';
import 'package:ksij_kinshasa/pages/cours/login/login_controller.dart';
import 'package:ksij_kinshasa/utils/langi.dart';
import 'package:ksij_kinshasa/utils/local_notification_service.dart';
import 'package:ksij_kinshasa/utils/notification_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';
import 'calendrier/calendrier.dart';
import 'calendrier/calendrier_controller.dart';
import 'coran/coran.dart';
import 'cours/login/login.dart';
import 'home/home.dart';
import 'home/live/live.dart';
import 'horaires/horaire.dart';
import 'dart:math' as math;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _Accueil();
}

class _Accueil extends State<Accueil> with TickerProviderStateMixin {
  late final TabController _tabController;
  LoginController loginController = Get.put(LoginController());
  //
  Rx<Widget> vue = Rx(const Home());
  RxInt choix = 0.obs;
  //
  List angles = [
    {"titre": "Home", "icon": "MaterialSymbolsMosqueRounded"},
    {"titre": "Live", "icon": "IconParkSolidPlay"},
    {"titre": "Calendar", "icon": "PhCalendarCheckFill"},
    {"titre": "Times", "icon": "TablerPray"},
    {"titre": "Madressa", "icon": "MdiAccountSchool"},
    {"titre": "Contacts", "icon": "IcBaselineAssignmentInd"},
  ];

  //
  @override
  void initState() {
    //
    //   AwesomeNotifications().setListeners(
    //       onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    //       onNotificationCreatedMethod:
    //           NotificationController.onNotificationCreatedMethod,
    //       onNotificationDisplayedMethod:
    //           NotificationController.onNotificationDisplayedMethod,
    //       onDismissActionReceivedMethod:
    //           NotificationController.onDismissActionReceivedMethod);
    //   //
    //   super.initState();
    //   _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Langi.base1,
      child: SafeArea(
        child: Scaffold(
          body: Obx(() => vue.value),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     //
          //     Map<String, dynamic> e = {};
          //     //
          //     e["id"] = "123KKL";
          //     e["titre"] = "Un titre et tout";
          //     e["contenu"] = "vijdnsdj bjk dsb ldvsljd sljdsg lu";
          //     e["auteur"] = "vdkjn ovd";
          //     e["dateTime"] = "25-1-2024";
          //     e["sousTitre"] = "Sous titre";
          //     e["asPhoto"] = "false";
          //     //
          //     DateTime lelo = DateTime(2024, 1, 26, 11, 28);
          //     //lelo
          //     var Diff = lelo.difference(DateTime.now());
          //     print("seconde: ${Diff.inSeconds}");
          //     int sec = Diff.inSeconds;
          //     //
          //     Map message = {
          //       "titre": "Namaaz Timings",
          //       "data": "Maghrib 15:30"
          //     };
          //     //
          //     Workmanager().registerOneOffTask(
          //       "oneoff-task-identifier",
          //       jsonEncode(message),
          //       initialDelay: Duration(seconds: 10),
          //     );
          //     //
          //     //LocalNotificationService.rappel(message);
          //     //LocalNotificationService.zonedScheduleNotification(
          //     //  "Salut", DateTime(2024, 01, 26, 10, 30), "Truc");
          //   },
          //   child: const Icon(Icons.add),
          // ),
          bottomNavigationBar: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(angles.length, (index) {
                Map e = angles[index];
                return InkWell(
                  onTap: () {
                    //
                    choix.value = index;
                    //
                    if (choix.value == 0) {
                      vue.value = const Home();
                    } else if (choix.value == 1) {
                      vue.value = Live();
                    } else if (choix.value == 2) {
                      vue.value = Calendrier();
                    } else if (choix.value == 3) {
                      vue.value = Horaire();
                    } else if (choix.value == 4) {
                      vue.value = Login();
                    } else {
                      vue.value = Contacts();
                    }
                  },
                  child: Obx(
                    () => Container(
                      //flex: 1,
                      width: 50,
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/${e["icon"]}.svg",
                            colorFilter: index == choix.value
                                ? ColorFilter.mode(Langi.base2, BlendMode.srcIn)
                                : ColorFilter.mode(
                                    Colors.grey, BlendMode.srcIn),
                            semanticsLabel: e["titre"],
                            height: 30,
                            width: 30,
                          ),
                          Text(
                            e["titre"],
                            style: TextStyle(
                              fontSize: 10,
                              color: index == choix.value
                                  ? Langi.base2
                                  : Colors.grey,
                              fontWeight: index == choix.value
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     //
          //     // AwesomeNotifications().createNotification(
          //     //   content: NotificationContent(
          //     //     id: 10,
          //     //     channelKey: 'basic_channel',
          //     //     actionType: ActionType.Default,
          //     //     title: 'Hello World!',
          //     //     body: 'This is my first notification!',
          //     //   ),
          //     //   // actionButtons: [
          //     //   //   NotificationActionButton(key: 'key_voir', label: 'View'),
          //     //   //   NotificationActionButton(key: 'key_annuler', label: 'Cancel'),
          //     //   // ],
          //     // );
          //   },
          //   child: Icon(Icons.add),
          // ),
        ),
      ),
    );
  }
}
