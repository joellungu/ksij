import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ksij_kinshasa/pages/cours/login/login_controller.dart';
import 'package:ksij_kinshasa/utils/langi.dart';

import 'calendrier/calendrier.dart';
import 'calendrier/calendrier_controller.dart';
import 'coran/coran.dart';
import 'cours/login/login.dart';
import 'home/home.dart';
import 'horaires/horaire.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _Accueil();
}

class _Accueil extends State<Accueil> with TickerProviderStateMixin {
  late final TabController _tabController;
  CalendrierController calendrierController = Get.put(CalendrierController());
  LoginController loginController = Get.put(LoginController());
  //
  Rx<Widget> vue = Rx(const Home());
  RxInt choix = 0.obs;
  //
  List angles = [
    {"titre": "Home", "icon": "MaterialSymbolsMosqueRounded"},
    {"titre": "Coran", "icon": "MdiBookOpenPageVariant"},
    {"titre": "Calendar", "icon": "PhCalendarCheckFill"},
    {"titre": "Pray", "icon": "TablerPray"},
    {"titre": "School", "icon": "MdiAccountSchool"},
  ];
  //
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
                    vue.value = Home();
                  } else if (choix.value == 1) {
                    vue.value = PDFScreen();
                  } else if (choix.value == 2) {
                    vue.value = Calendrier();
                  } else if (choix.value == 3) {
                    vue.value = Horaire();
                  } else {
                    vue.value = Login();
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
                              : ColorFilter.mode(Colors.grey, BlendMode.srcIn),
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
      )),
    );
  }
}
