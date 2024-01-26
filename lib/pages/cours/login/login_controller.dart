import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksij_kinshasa/pages/cours/cours.dart';
import 'package:ksij_kinshasa/utils/requete.dart';

class LoginController extends GetxController {
  //
  Requete requete = Requete();
  //
  Future<void> login(Map e) async {
    //pseudo,pwd,profil, etat

    //
    Response rep =
        await requete.getE("utilisateur/login/${e['pwd']}/${e['telephone']}");
    if (rep.isOk) {
      //
      print("rep: ${rep.body}");
      Map e = rep.body;

      print(rep.body);
      //
      Get.back();
      Get.to(Cours(e["niveau"]));
      //
    } else {
      print("rep: ${rep.statusCode}");
      print("rep: ${rep.body}");
      Get.back();
      Get.snackbar(
        "Error",
        "No account with this information",
        colorText: Colors.white,
        backgroundColor: Colors.red.shade900,
      );
    }
    //
  }
}
