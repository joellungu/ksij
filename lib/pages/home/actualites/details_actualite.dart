import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ksij_kinshasa/utils/langi.dart';
import 'package:ksij_kinshasa/utils/requete.dart';

class DetailsActualite extends StatelessWidget {
  //
  Map e;
  //
  DetailsActualite(this.e);
  //
  @override
  Widget build(BuildContext context) {
    //
    String date = "";
    try {
      bool v = isDate(e['dateTime']);
      print("pass: $v");
      date = v ? dateFormater(e['dateTime']) : '';
    } catch (e) {
      print("erreur: $e");
    }
    //
    return Scaffold(
      appBar: AppBar(
        //${e['titre']}
        leading: IconButton(
          onPressed: () {
            //
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "News Details",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Langi.base1,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 70,
                color: Langi.base1,
              ),
              Expanded(
                flex: 8,
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, right: 5, left: 5),
            child: Align(
              alignment: Alignment.topCenter,
              child: Card(
                elevation: 3,
                color: Colors.white,
                child: SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          title: Text(
                            "${e['titre']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          subtitle: Text(
                            date,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      e["asPhoto"]
                          ? InkWell(
                              onTap: () {
                                Get.dialog(
                                  Container(
                                    height: Get.size.height / 1.5,
                                    width: Get.width / 1.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          color: Langi.base1,
                                          child: IconButton(
                                            onPressed: () {
                                              //
                                              Get.back();
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "${Requete.url}/infos/photo/${e["id"]}"),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "${Requete.url}/infos/photo/${e["id"]}"),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      const Padding(
                        padding: EdgeInsets.only(right: 5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 120, right: 5, left: 5),
            child: Align(
              alignment: Alignment.topCenter,
              child: Card(
                elevation: 3,
                color: Colors.white,
                child: Container(
                  height: Get.size.height / 1.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: ListView(
                            children: [
                              Text(
                                "${e['contenu']}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "${Requete.url}/infos/photo/${e["id"]}"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${e['sousTitre'] ?? ''}"),
                            const Text(
                              "Date",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blue),
                            ),
                            Text(
                              date,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
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

/**
 * ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Text("${e['contenu']}\n\n"),
          Text("Date: ${e['dateTime']}"),
        ],
      ),
 */