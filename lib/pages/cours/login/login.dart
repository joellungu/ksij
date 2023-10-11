import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ksij_kinshasa/pages/cours/cours.dart';
import 'package:ksij_kinshasa/utils/langi.dart';

import 'login_controller.dart';

class Login extends StatelessWidget {
  //
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final mdp = TextEditingController();
  //
  RxBool vue = true.obs;

  LoginController loginController = Get.find();
  RxBool masquer = true.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Langi.base1, // Status bar color
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Connexion",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            elevation: 0,
            backgroundColor: Langi.base1,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 100,
                        child: SvgPicture.asset(
                          "assets/PhUserDuotone.svg",

                          colorFilter:
                              ColorFilter.mode(Langi.base2, BlendMode.srcIn),

                          //semanticsLabel: e["titre"],
                          height: 100,
                          width: 100,
                        ),
                      ),
                      // Image.asset(
                      //   "assets/logo_MIN SANTE.png",
                      //   width: 300,
                      //   height: 300,
                      // ),
                      const SizedBox(
                        height: 70,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Connectez-vous pour avoir accès au contenu du cours",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      TextFormField(
                        controller: email,
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "Veuilliez inserer votre email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          prefixIcon: const Icon(Icons.email),
                          hintText: "Email",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => TextFormField(
                          controller: mdp,
                          obscureText: masquer.value,
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Please put your email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Obx(
                              () => IconButton(
                                icon: vue.value
                                    ? Icon(Icons.lock)
                                    : Icon(Icons.lock),
                                onPressed: () {
                                  //
                                  masquer.value = !masquer.value;
                                },
                              ),
                            ),
                            hintText: "Pass word",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            //Get.off(Accueil());

                            Get.dialog(Container(
                              height: 40,
                              width: 40,
                              child: const CircularProgressIndicator(),
                              alignment: Alignment.center,
                            ));

                            // Timer(Duration(seconds: 3), () {
                            //   Get.back();
                            //   Get.off(Accueil());
                            // });
                            Map e = {
                              "email": email.text,
                              "pwd": mdp.text,
                            };
                            //loginController.login(e);
                            Get.to(Cours());
                            //loginController.deja.value = true;
                          }
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            Size(
                              double.maxFinite,
                              45,
                            ),
                          ),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all(Langi.base1),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // OutlinedButton(
                      //   onPressed: () {
                      //     //
                      //     //Get.to(MdpOublie());
                      //   },
                      //   style: ButtonStyle(
                      //     fixedSize: MaterialStateProperty.all(
                      //       Size(
                      //         double.maxFinite,
                      //         45,
                      //       ),
                      //     ),
                      //     shape:
                      //         MaterialStateProperty.all(RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20),
                      //     )),
                      //     //backgroundColor:
                      //     //  MaterialStateProperty.all(Colors.red.shade900),
                      //   ),
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     width: double.maxFinite,
                      //     child: const Text(
                      //       "Mot de passe oublié",
                      //       style: TextStyle(
                      //         color: Colors.black,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  //)
                ),
              ),
            ),
          ),
          // bottomNavigationBar: Container(
          //   height: 70,
          //   alignment: Alignment.center,
          //   child: SvgPicture.asset(
          //     "assets/PhUserDuotone.svg",
          //     colorFilter: ColorFilter.mode(Langi.base2, BlendMode.srcIn),

          //     //semanticsLabel: e["titre"],
          //     height: 30,
          //     width: 30,
          //   ),
          // ),
          // RichText(
          //   textAlign: TextAlign.center,
          //   text: TextSpan(
          //     text: "Power by\n",
          //     style: const TextStyle(
          //       color: Colors.black,
          //       fontWeight: FontWeight.bold,
          //     ),
          //     children: [
          //       TextSpan(
          //         text: "SkyTechnologie",
          //         style: TextStyle(
          //           color: Colors.grey.shade700,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
