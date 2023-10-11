import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ksij_kinshasa/pages/horaires/horaire_controller.dart';
import 'package:ksij_kinshasa/utils/langi.dart';
import 'package:ksij_kinshasa/utils/util.dart';
import 'package:path_provider/path_provider.dart';

import 'actualites/actualites.dart';
import 'evenements/evenement.dart';
import 'live/live.dart';
import 'mecque/mecque.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> with TickerProviderStateMixin {
  late final TabController _tabController;
  //ChallengeController challengeController = Get.put(ChallengeController());
  //MessageController messageController = Get.put(MessageController());
  //
  HoraireController horaireController = Get.put(HoraireController());
  //
  @override
  void initState() {
    //
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
              centerTitle: true,
              backgroundColor: Langi.base1,
              title: Text(
                "KSIJ KINSHASA",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                indicatorColor: Langi.base2,
                indicatorWeight: 5,
                tabs: [
                  Tab(
                    text: "Events",
                    icon: SvgPicture.asset(
                      "assets/HeroiconsCalendarDaysSolid.svg",
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      //semanticsLabel: e["titre"],
                      height: 30,
                      width: 30,
                    ),
                  ),
                  Tab(
                    text: "News",
                    icon: SvgPicture.asset(
                      "assets/JamNewspaperF.svg",
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      //semanticsLabel: e["titre"],
                      height: 30,
                      width: 30,
                    ),
                  ), //
                  Tab(
                    text: "Streaming",
                    icon: SvgPicture.asset(
                      "assets/IconParkSolidPlay.svg",
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      //semanticsLabel: e["titre"],
                      height: 30,
                      width: 30,
                    ),
                  ),
                  Tab(
                    text: "Mecque",
                    icon: SvgPicture.asset(
                      "assets/PhCompassFill.svg",
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      //semanticsLabel: e["titre"],
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                SizedBox(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          color: Colors.white,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Evenements(),
                              Actualite(),
                              Live(),
                              Mecque(),
                            ],
                          ),
                        ),
                      ),
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
            )),
      ),
    );
  }
}
