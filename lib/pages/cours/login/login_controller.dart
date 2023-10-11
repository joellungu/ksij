import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksij_kinshasa/utils/requete.dart';

class LoginController extends GetxController {
  //
  Requete requete = Requete();
  //
  Future<void> login(Map e) async {
    //pseudo,pwd,profil, etat
    print(
        "${Requete.url}/api/?_c=user&_a=login&email=${e['email']}&pwd=${e['pwd']}&profil=agent");
    //
    Response rep = await requete.getE(
        "/api/?_c=user&_a=login&email=${e['email']}&pwd=${e['pwd']}&profil=agent");
    if (rep.statusCode == 200 || rep.statusCode == 201) {
      //
      print("rep: ${rep.body}");
      Map e = rep.body;
      if (e["statut"] != null) {
        //
        if (e["statut"] == "non actif") {
          //
          print(rep.body);
          //

          //
          //box.write("user", rep.body);
          Get.back();
          Get.snackbar(
            "Compte",
            "Votre compte n'est pas actif veuillez contacter votre administrateur",
            backgroundColor: Colors.red.shade700,
            colorText: Colors.white,
          );
        } else {
          //
          print(rep.body);
          //
          //box.write("user", rep.dabodyta);
          //
          //box.write("user", rep.body);
          Get.back();
          //Get.to(Accueil());
          //Get.snackbar("Succès", "L'authentification éffectué !");
        }
      } else {
        Get.back();
        Get.snackbar(
          "Oups",
          "Veuillez contacter votre administrateur. Compte non valide",
          colorText: Colors.white,
          backgroundColor: Colors.red.shade900,
        );
      }
      //
    } else {
      //
      print(rep.statusCode);
      print(rep.body);
      //
      Get.back();
      Get.snackbar("Erreur", "Un problème lors de la suppression");
    }
  }
}
