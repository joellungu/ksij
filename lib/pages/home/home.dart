import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:jhijri/jHijri.dart';
import 'package:ksij_kinshasa/pages/horaires/horaire_controller.dart';
import 'package:ksij_kinshasa/utils/langi.dart';
import 'package:ksij_kinshasa/utils/requete.dart';
import 'package:ksij_kinshasa/utils/util.dart';
import 'package:path_provider/path_provider.dart';

import 'actualites/actualite_controller.dart';
import 'actualites/actualites.dart';
import 'actualites/details_actualite.dart';
import 'evenements/details_evenement.dart';
import 'evenements/evenement.dart';
import 'evenements/evenement_controller.dart';
import 'live/live.dart';
import 'mecque/mecque.dart';
import 'parametre.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> with TickerProviderStateMixin {
  late final TabController _tabController;
  EvenementController evenementController = Get.put(EvenementController());
  ActualiteController actualiteController = Get.put(ActualiteController());
  //
  HoraireController horaireController = Get.put(HoraireController());
  //
  DateTime d = DateTime.now();
  //
  String date1 = "";
  String date2 = "";
  String date3 = "";
  //
  @override
  void initState() {
    //
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    //
    var dd = JHijri(fDate: d);
    //dd.monthName
    date1 = "${dd.day}"; //${dd.year}
    date2 = dd.monthName; //${dd.year}
    date3 = "${dd.year}"; //${dd.year}
    print("la date: $date1 ---- ${date2} ---- $date3");
  }

  //

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
          appBar: AppBar(
            backgroundColor: Langi.base1,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //margin: EdgeInsets.only(left: 0),
                  height: 50,
                  width: 50,
                  //child: Image.asset("assets/logo mosquer.png"),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: ExactAssetImage(
                        "assets/logo mosquer.png",
                      ),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                Text(
                  "$date1 - $date2",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  //margin: EdgeInsets.only(left: 0),
                  height: 50,
                  width: 50,
                  child: IconButton(
                      onPressed: () {
                        //GalaBell.svg
                        Get.to(Parametre());
                        //
                      },
                      icon: SvgPicture.asset(
                        "assets/GalaSettings.svg",
                        colorFilter:
                            ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        semanticsLabel: "GalaSettings.svg",
                        height: 30,
                        width: 30,
                      )),
                )
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                color: Langi.base1,
                height: Get.size.height / 7,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "KSIJ KINSHASA",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    // TabBar(
                    //   controller: _tabController,
                    //   labelColor: Colors.white,
                    //   unselectedLabelColor: Colors.white,
                    //   indicatorColor: Langi.base2,
                    //   indicatorWeight: 5,
                    //   tabs: [
                    //     Tab(
                    //       text: "Events",
                    //       icon: SvgPicture.asset(
                    //         "assets/HeroiconsCalendarDaysSolid.svg",
                    //         colorFilter: ColorFilter.mode(
                    //             Colors.white, BlendMode.srcIn),
                    //         //semanticsLabel: e["titre"],
                    //         height: 30,
                    //         width: 30,
                    //       ),
                    //     ),
                    //     Tab(
                    //       text: "News",
                    //       icon: SvgPicture.asset(
                    //         "assets/JamNewspaperF.svg",
                    //         colorFilter: ColorFilter.mode(
                    //             Colors.white, BlendMode.srcIn),
                    //         //semanticsLabel: e["titre"],
                    //         height: 30,
                    //         width: 30,
                    //       ),
                    //     ), //
                    //     // Tab(
                    //     //   text: "Streaming",
                    //     //   icon: SvgPicture.asset(
                    //     //     "assets/IconParkSolidPlay.svg",
                    //     //     colorFilter:
                    //     //         ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    //     //     //semanticsLabel: e["titre"],
                    //     //     height: 30,
                    //     //     width: 30,
                    //     //   ),
                    //     // ),
                    //     // Tab(
                    //     //   text: "Mecque",
                    //     //   icon: SvgPicture.asset(
                    //     //     "assets/PhCompassFill.svg",
                    //     //     colorFilter:
                    //     //         ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    //     //     //semanticsLabel: e["titre"],
                    //     //     height: 30,
                    //     //     width: 30,
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  //controller: _tabController,
                  children: [
                    Expanded(
                      flex: 4,
                      child: FutureBuilder(
                        future: evenementController.allEvents(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List cards = snapshot.data!;
                            return Center(
                              child: SizedBox(
                                height: 110,
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 10,
                                        bottom: 10,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Events",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListView(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(cards.length,
                                            (index) {
                                          Map card = cards[index];
                                          print("card: $card");

                                          bool v = isDate(card['dateTime']);
                                          print("pass: $v");
                                          String date = v
                                              ? dateFormater(card['dateTime'])
                                              : '';

                                          return Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            height: 60,
                                            width: Get.size.width / 1.2,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: ListTile(
                                                    onTap: () {
                                                      //
                                                      Get.to(DetailsEvenement(
                                                          card));
                                                    },
                                                    title: Text(
                                                      "${card['titre']}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      date,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                card["asPhoto"]
                                                    ? Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                "${Requete.url}/evenement/photo/${card["id"]}"),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Container();
                          }
                          return Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: FutureBuilder(
                        future: actualiteController.allEvents(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List cards = snapshot.data!;
                            return Center(
                              child: Container(
                                height: 110,
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 10,
                                        bottom: 10,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "News",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListView(
                                        padding: EdgeInsets.only(left: 10),
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(cards.length,
                                            (index) {
                                          Map card = cards[index];
                                          print("card: $card");
                                          String date = "";
                                          try {
                                            bool v = isDate(card['dateTime']);
                                            print("pass: $v");
                                            date = v
                                                ? dateFormater(card['dateTime'])
                                                : '';
                                          } catch (e) {
                                            print("erreur: $e");
                                          }

                                          return Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            height: 60,
                                            width: Get.size.width / 1.5,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: ListTile(
                                                    onTap: () {
                                                      //
                                                      Get.to(
                                                        DetailsActualite(card),
                                                      );
                                                    },
                                                    title: Text(
                                                      "${card['titre']}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      date,
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      overflow:
                                                          TextOverflow.clip,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                                card["asPhoto"]
                                                    ? Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                "${Requete.url}/infos/photo/${card["id"]}"),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Container();
                          }
                          return Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    )
                    //Evenements(),
                    // Actualite(),
                    //Live(),
                    //Mecque(),
                  ],
                ),
              ),
              // Align(
              //     alignment: Alignment.topCenter,
              //     child: Padding(
              //       padding: const EdgeInsets.only(
              //         left: 20,
              //         right: 20,
              //         top: 150,
              //         bottom: 20,
              //       ),
              //       //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              //       child: Container(
              //         //elevation: 1,
              //         // shape: RoundedRectangleBorder(
              //         //   borderRadius: BorderRadius.circular(20),
              //         // ),
              //         color: Colors.transparent,
              //         child: SizedBox(
              //           height: Get.size.height / 1.2,
              //           width: Get.size.width / 1.2,
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Card(
              //                 elevation: 1,
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(20),
              //                 ),
              //                 child: Container(
              //                   padding: const EdgeInsets.all(5),
              //                   height: 150,
              //                   width: double.maxFinite,
              //                   child: Column(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceAround,
              //                     children: [
              //                       Expanded(
              //                         flex: 3,
              //                         child: Container(
              //                           alignment: Alignment.centerLeft,
              //                           child: SvgPicture.asset(
              //                             "assets/IconParkOutlineMicroscopeOne.svg",
              //                             colorFilter: ColorFilter.mode(
              //                                 Colors.deepPurple, BlendMode.srcIn),
              //                             semanticsLabel: "",
              //                             height: 30,
              //                             width: 30,
              //                           ),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         flex: 5,
              //                         child: Container(
              //                           child: ListTile(
              //                             // leading: Container(
              //                             //   height: 50,
              //                             //   width: 50,
              //                             //   alignment: Alignment.center,
              //                             //   child: Icon(
              //                             //     CupertinoIcons.person,
              //                             //     color: Colors.black,
              //                             //     size: 35,
              //                             //   ),
              //                             //   decoration: BoxDecoration(
              //                             //       borderRadius: BorderRadius.circular(25),
              //                             //       color: Colors.deepPurple.shade100
              //                             //           .withOpacity(0.7)),
              //                             // ),
              //                             title: Text(
              //                               "Challenges",
              //                               style: TextStyle(
              //                                 color: Colors.black,
              //                                 fontWeight: FontWeight.bold,
              //                                 fontSize: 25,
              //                               ),
              //                             ),
              //                             subtitle: Text(
              //                               "Gagnez de nombreux prix en participant à des Challenges",
              //                               style: TextStyle(
              //                                 color: Colors.white,
              //                                 fontWeight: FontWeight.bold,
              //                                 fontSize: 15,
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         flex: 3,
              //                         child: Container(
              //                           alignment: Alignment.centerRight,
              //                           child: TextButton(
              //                             onPressed: () {},
              //                             child: Text(" Voir "),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               Expanded(
              //                 //height: 330,
              //                 //color: Colors.red,
              //                 flex: 1,
              //                 child: GridView.count(
              //                   padding: EdgeInsets.only(
              //                     top: 0,
              //                   ),
              //                   crossAxisCount: 2,
              //                   crossAxisSpacing: 2,
              //                   mainAxisSpacing: 5,
              //                   childAspectRatio: 1.2,
              //                   children: List.generate(
              //                     angles.length,
              //                     (index) {
              //                       Map e = angles[index];
              //                       return InkWell(
              //                         onTap: () {
              //                           //
              //                           if (index == 0) {
              //                             //
              //                             //Get.to(const Calendrier());
              //                             //
              //                           } else if (index == 2) {
              //                             //
              //                             //Get.to(const Statistique());
              //                             //
              //                           } else if (index == 3) {
              //                             //
              //                             //Get.to(Challenge());
              //                             //
              //                           } else if (index == 4) {
              //                             //
              //                             //Get.to(Aide());
              //                             //
              //                           } else if (index == 5) {
              //                             //
              //                             //Get.to(Profil());
              //                             //
              //                           } else {
              //                             //
              //                             //Get.to(const Tests());
              //                             //
              //                           }
              //                         },
              //                         child: Card(
              //                           //color: Colors.tealAccent,
              //                           child: Column(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceAround,
              //                             children: [
              //                               SvgPicture.asset(
              //                                 "assets/${e["icon"]}.svg",
              //                                 colorFilter: ColorFilter.mode(
              //                                     Colors.deepPurple,
              //                                     BlendMode.srcIn),
              //                                 semanticsLabel: e["titre"],
              //                                 height: 70,
              //                                 width: 70,
              //                               ),
              //                               Text(
              //                                 e["titre"],
              //                                 style: TextStyle(
              //                                     fontSize: 12,
              //                                     fontWeight: FontWeight.bold,
              //                                     color: Colors.white.shade900),
              //                               )
              //                             ],
              //                           ),
              //                         ),
              //                       );
              //                     },
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }

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
