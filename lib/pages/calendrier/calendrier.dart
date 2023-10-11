import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
//import 'package:ksij_kinshasa/pages/horaires/horaire_controller.dart';
import 'package:ksij_kinshasa/utils/langi.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calendrier_controller.dart';

class Calendrier extends GetView<CalendrierController> {
  //
  Rx<DateTime> date = Rx(DateTime.now());
  //
  List horaires = [
    {"priere": "Imsak", "heure": "5:52 am"},
    {"priere": "Fajr", "heure": "6:30 am"},
    {"priere": "Sunrise", "heure": "7:12 am"},
    {"priere": "Zuhr", "heure": "12:02 pm"},
    {"priere": "Sunset", "heure": "4:50 pm"},
    {"priere": "Maghrib", "heure": "4:58 pm"},
  ];
  //
  List evenements = [
    {"titre": "Wednesday Octobre 11", "contenu": "Rabi AL Awwal"},
    {"titre": "Wednesday Octobre 12", "contenu": "Rabi AL Awwal 26"},
    {"titre": "Wednesday Octobre 14", "contenu": "Rabi AL Thaani 15"},
    {"titre": "Wednesday Octobre 14", "contenu": "Rabi AL Thaani 12"},
  ];
  //
  RxString titre = "".obs;
  RxString contenu = "".obs;
  //
  @override
  Widget build(BuildContext context) {
    //
    return Container(
      color: Langi.base1,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Langi.base1,
            centerTitle: true,
            title: const Text(
              "Calendar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  //height: Get.size.height / 1.9,
                  child: Obx(
                    () => TableCalendar(
                      selectedDayPredicate: (day) {
                        return isSameDay(date.value, day);
                      },
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: date.value,
                      daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                        color: Langi.base1,
                      )),
                      onDaySelected: (d, t) {
                        date.value = d;
                        print("d: $d");
                        print("t: $t");
                        var n = Random();
                        Map e = evenements[n.nextInt(3)];
                        titre.value = e['titre'];
                        contenu.value = e['contenu'];
                      },
                    ),
                  ),
                ),
                Card(
                  //
                  elevation: 3,
                  //padding: EdgeInsets.all(5),
                  //color: Colors.teal,
                  child: Container(
                    height: Get.size.height / 3,
                    width: Get.size.width / 1.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Obx(
                            () => Text(
                              titre.value,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child:
                              Text("Wiladat of 11th ImamHassan AL-Askari (a)"),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Obx(
                            () => Text(
                              contenu.value,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
