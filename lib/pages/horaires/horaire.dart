import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ksij_kinshasa/pages/horaires/horaire_controller.dart';
import 'package:ksij_kinshasa/utils/langi.dart';
import 'package:table_calendar/table_calendar.dart';

class Horaire extends GetView<HoraireController> {
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
  Horaire() {
    controller.allPrayOfDay(
        "${date.value.day}-${date.value.month}-${date.value.year}");
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
              "Namaaz Timings",
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
                        //
                        controller.allPrayOfDay(
                            "${date.value.day}-${date.value.month}-${date.value.year}");
                        //
                      },
                    ),
                  ),
                ),
                Container(
                  //height: Get.size.height / 1.5,
                  padding: EdgeInsets.all(5),
                  //color: Colors.teal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        //height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Langi.base1,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Langi.base1,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Obx(
                                () => Text(
                                  dateFormater(
                                      "${date.value.day}-${date.value.month}-${date.value.year}"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            controller.obx(
                              (state) {
                                Map o = state!;
                                List hs = o['horaires'];
                                return Column(
                                  children: List.generate(hs.length, (index) {
                                    Map h = hs[index];
                                    return Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      height: 40,
                                      color: index % 2 == 1
                                          ? Colors.grey.shade200
                                          : Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text("${h['priere']}"),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text("${h['heure']}"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                );
                              },
                              onEmpty: Container(),
                              onLoading: Center(
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: const CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
