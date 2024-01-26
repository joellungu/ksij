import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jhijri/jHijri.dart';
//import 'package:ksij_kinshasa/pages/horaires/horaire_controller.dart';
import 'package:ksij_kinshasa/utils/langi.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calendrier_controller.dart';

class Calendrier extends GetView<CalendrierController> {
  //
  Rx<DateTime> date = Rx(DateTime.now());
  //
  final box = GetStorage();

  //
  var jHijri = JHijri(fDate: DateTime.now());
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
  RxString event = "".obs;
  RxString contenu = "".obs;
  //
  Calendrier() {
    controller.getAllDate();
    DateTime d = DateTime.now();
    //
    var dd = JHijri(fDate: d);
    //dd.monthName
    var date1 = "${dd.day}"; //${dd.year}
    var date2 = dd.monthName; //${dd.year}
    var date3 = "${dd.year}"; //${dd.year}
    //
    contenu.value = "$date1 - $date2";
    titre.value = "${date.value.day}-${date.value.month}-${date.value.year}";
  }
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
                      // eventLoader: (day) {
                      //   return [
                      //     DateTime(2023, 10, 17),
                      //     DateTime(2023, 10, 18),
                      //     DateTime(2023, 10, 18),
                      //   ];
                      // },
                      //

                      //
                      calendarBuilders: CalendarBuilders(
                        // todayBuilder: (context, day, d) {
                        //   if (day.weekday == day.weekday) {
                        //     final text = DateFormat.E().format(day);

                        //     return Center(
                        //       child: Text(
                        //         text,
                        //         style: TextStyle(color: Colors.red),
                        //       ),
                        //     );
                        //   }
                        // },
                        markerBuilder: (context, day, d) {
                          //var ds = DateTime.now();
                          List cls = box.read("calendrier") ?? [];
                          //print("d1: $day");
                          //print("d1: $ds");
                          //print(
                          //  "==: ${day.year == ds.year} == ${day.month == ds.month} == ${day.day == ds.day}");
                          for (Map e in cls) {
                            String dateTime = e['dateTime'];
                            List d1s = dateTime.split("-");
                            print("date: $d1s");
                            if (day.year == int.parse("${d1s[2]}") &&
                                day.month == int.parse("${d1s[1]}") &&
                                day.day == int.parse("${d1s[0]}")) {
                              final text = DateFormat.E().format(day);

                              return Center(
                                child: Container(
                                  //margin: EdgeInsets.all(5),
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: e["couleur"] == 1
                                        ? Colors.green
                                        : Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "${day.day}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        dowBuilder: (context, day) {
                          if (day.weekday == DateTime.sunday) {
                            final text = DateFormat.E().format(day);

                            return Center(
                              child: Text(
                                text,
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          }
                        },
                      ),
                      //
                      daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                        color: Langi.base1,
                      )),
                      onDaySelected: (d, t) {
                        date.value = d;
                        print("d: $d");
                        print("t: $t");
                        //
                        List cls = box.read("calendrier") ?? [];
                        //print("d1: $day");
                        //print("d1: $ds");
                        //print(
                        //  "==: ${day.year == ds.year} == ${day.month == ds.month} == ${day.day == ds.day}");
                        for (Map e in cls) {
                          String dateTime = e['dateTime'];
                          List d1s = dateTime.split("-");
                          print("date: $d1s");
                          if (d.year == int.parse("${d1s[2]}") &&
                              d.month == int.parse("${d1s[1]}") &&
                              d.day == int.parse("${d1s[0]}")) {
                            //

                            var dd = JHijri(fDate: d);
                            //dd.monthName
                            var date1 = "${dd.day}"; //${dd.year}
                            var date2 = dd.monthName; //${dd.year}
                            var date3 = "${dd.year}"; //${dd.year}
                            //
                            contenu.value = "$date1 - $date2";
                            titre.value = "${d.day}-${d.month}-${d.year}";

                            //titre.value = e['titre'] ?? "";
                            event.value = e['contenu'] ?? "";
                            break;
                          } else {
                            //
                            var dd = JHijri(fDate: d);
                            //dd.monthName
                            var date1 = "${dd.day}"; //${dd.year}
                            var date2 = dd.monthName; //${dd.year}
                            var date3 = "${dd.year}"; //${dd.year}
                            //
                            contenu.value = "$date1 - $date2";
                            titre.value = "${d.day}-${d.month}-${d.year}";

                            //titre.value = e['titre'] ?? "";
                            event.value = "";
                          }
                        }
                        // var n = Random();
                        // Map e = evenements[n.nextInt(3)];
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
                    height: Get.size.height / 5,
                    width: Get.size.width / 1.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Obx(
                            () => Text(
                              isDate(titre.value)
                                  ? dateFormater(titre.value)
                                  : '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Obx(
                            () => Text(event.value),
                          ),
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

  //
  bool isDate(String date) {
    List ds = date.split("-");
    print("ds: $ds");
    print("ds: ${ds.length}");
    try {
      if (ds.length == 3) {
        //DateTime(int.parse(ds[2]), int.parse(ds[1]), int.parse(ds[0]));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  String dateFormater(String date) {
    List ds = date.split("-");
    print("ds: $ds");
    DateTime now =
        DateTime(int.parse(ds[2]), int.parse(ds[1]), int.parse(ds[0]));
    String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(now);
    print(formattedDate);
    return formattedDate;
  }
}
