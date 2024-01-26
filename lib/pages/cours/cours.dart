import 'dart:typed_data';
import 'package:dio/dio.dart' as io;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksij_kinshasa/utils/langi.dart';
import 'package:ksij_kinshasa/utils/requete.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Cours extends StatelessWidget {
  //
  late PdfViewerController _pdfViewerController;
  //
  int classe;
  Cours(this.classe) {
    _pdfViewerController = PdfViewerController();
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              //
              Get.back();
              //
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Portal class $classe",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 0,
          backgroundColor: Langi.base1,
        ),
        body: FutureBuilder(
          future: allCours(classe),
          builder: (c, t) {
            if (t.hasData) {
              List us = t.data as List;
              return ListView(
                padding: const EdgeInsets.all(10),
                children: List.generate(us.length, (index) {
                  Map u = us[index];
                  return ListTile(
                    onTap: () {
                      //
                      Get.to(
                        Lire(
                          u['niveau'],
                          u['id'],
                        ),
                      );
                      //detail.value = Details(u);
                    },
                    leading: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                      ),
                      child: SvgPicture.asset(
                        "assets/MdiBookOpenPageVariant.svg",
                        colorFilter:
                            ColorFilter.mode(Langi.base2, BlendMode.srcIn),
                        semanticsLabel: "",
                        height: 30,
                        width: 30,
                      ),
                    ),
                    title: Text("${u['titre']}"),
                    subtitle: Text("Leve ${u['niveau']}"),
                    // trailing: IconButton(
                    //   onPressed: () {
                    //     //
                    //     //controller.deleteCours("${u['id']}", niveau);
                    //     //
                    //   },
                    //   icon: Icon(
                    //     Icons.delete,
                    //     color: Colors.red.shade700,
                    //   ),
                    // ),
                  );
                }),
              );
            } else if (t.hasError) {
              return Container();
            }
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          },
        )
        // FutureBuilder(
        //   future: allEvents(classe),
        //   builder: (c, t) {
        //     if (t.hasData) {
        //       Map e = t.data as Map;
        //       if (e['erreur'] == null) {
        //         Uint8List data = e['pdf'];
        //         print(data);
        //         return SfPdfViewer.memory(
        //           data,
        //           controller: _pdfViewerController,
        //           currentSearchTextHighlightColor: Colors.yellow.withOpacity(0.6),
        //           otherSearchTextHighlightColor: Colors.yellow.withOpacity(0.3),
        //         );
        //       } else {
        //         return Container();
        //       }
        //     } else if (t.hasError) {
        //       return Container();
        //     }
        //     return Center(
        //       child: Container(
        //         height: 40,
        //         width: 40,
        //         child: CircularProgressIndicator(),
        //       ),
        //     );
        //   },
        // ),
        );
  }

  /**
   * SfPdfViewer.network(
          "${Requete.url}/niveau/f/$classe",
          controller: _pdfViewerController,
          currentSearchTextHighlightColor: Colors.yellow.withOpacity(0.6),
          otherSearchTextHighlightColor: Colors.yellow.withOpacity(0.3),
        )
   */

  Future<List> allCours(int niveau) async {
    //
    Requete requete = Requete();
    //
    Response response = await requete.getE("niveau/all/cours/$niveau");

    if (response.isOk) {
      //
      return response.body;
    } else {
      //
      return [];
    }
  }

  Future<Map> allEvents(int id) async {
    //
    Requete requete = Requete();

    //change([], status: RxStatus.loading());
    //
    //Response response = await requete.getE("niveau/file/$id");

    io.Dio dio = io.Dio();
    io.Response responses = await dio.get(
      "${Requete.url}/niveau/f/$id",
      options: io.Options(method: "POST", contentType: "*/*"),
    );

    if (responses.statusCode == 200 || responses.statusCode == 201) {
      //print("data: ${responses.data}");
      //
      //change(response.body, status: RxStatus.success());
      //String f = "";

      return {"pdf": Uint8List.fromList(responses.data.codeUnits)};
    } else {
      //
      //change([], status: RxStatus.empty());
      return {"erreur": ""};
    }
  }
}

class Lire extends StatelessWidget {
  int classe;
  int id;
  late PdfViewerController _pdfViewerController;
  //
  Lire(this.classe, this.id) {
    _pdfViewerController = PdfViewerController();
  }
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              //
              Get.back();
              //
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Portal lecon $classe",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 0,
          backgroundColor: Langi.base1,
        ),
        body: SfPdfViewer.network(
          "${Requete.url}/niveau/f/cours/$id",
          controller: _pdfViewerController,
          currentSearchTextHighlightColor: Colors.yellow.withOpacity(0.6),
          otherSearchTextHighlightColor: Colors.yellow.withOpacity(0.3),
        )
        // FutureBuilder(
        //   future: allEvents(classe),
        //   builder: (c, t) {
        //     if (t.hasData) {
        //       Map e = t.data as Map;
        //       if (e['erreur'] == null) {
        //         Uint8List data = e['pdf'];
        //         print(data);
        //         return SfPdfViewer.memory(
        //           data,
        //           controller: _pdfViewerController,
        //           currentSearchTextHighlightColor: Colors.yellow.withOpacity(0.6),
        //           otherSearchTextHighlightColor: Colors.yellow.withOpacity(0.3),
        //         );
        //       } else {
        //         return Container();
        //       }
        //     } else if (t.hasError) {
        //       return Container();
        //     }
        //     return Center(
        //       child: Container(
        //         height: 40,
        //         width: 40,
        //         child: CircularProgressIndicator(),
        //       ),
        //     );
        //   },
        // ),
        );
  }
}


/**
 * GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 3,
        children: List.generate(11, (index) {
          return Card(
            elevation: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Text(
                      "Classe",
                      style: GoogleFonts.italiana(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "${index + 1}er",
                      style: GoogleFonts.italiana(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
 */
