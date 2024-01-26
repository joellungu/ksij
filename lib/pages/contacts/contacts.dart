import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksij_kinshasa/utils/langi.dart';

class Contacts extends StatelessWidget {
  //
  List contacts = [
    {
      "nom": "MAULANA RIZWAN AVD",
      "role": "RESIDENT AALIM",
      "phone": "+243822210216"
    },
    {"nom": "DILAWAR KHWAJA", "role": "PRESIDENT", "phone": "+243819900786"},
    {
      "nom": "SABIR POONAWALA",
      "role": "GENERAL SECRETARY",
      "phone": "+243819995786"
    },
    {
      "nom": "YOUSUF DALWALA",
      "role": "ASSISTANT GENERAL SECRETARY",
      "phone": "+243817712109"
    },
    {
      "nom": "ZAMIR ABBAS MISTRY",
      "role": "TREASURER ",
      "phone": "+243822633334"
    },
    {
      "nom": "NADIM VAZIR",
      "role": "COMMITTEE MEMBER",
      "phone": "+243990907777"
    },
    {
      "nom": "SHABBIR BHARVANI",
      "role": "COMMITTEE MEMBER",
      "phone": "+243999232914"
    },
    {
      "nom": "SOHAIL VIRANI",
      "role": "COMMITTEE MEMBER",
      "phone": "+243819910520"
    },
    {
      "nom": "HUSSAIN LAKHANI",
      "role": "COMMITTEE MEMBER",
      "phone": "+243998341576"
    },
    {
      "nom": "MISAM RAJSHI",
      "role": "COMMITTEE MEMBER",
      "phone": "+243810231658"
    },
    {"nom": "ZAHEER ABBAS", "role": "CARETAKER", "phone": "+243 892 755 236"},
    // {
    //   "nom": "MISAM RAJSHI",
    //   "role": "APP TECHNICAL SUPPORT",
    //   "phone": "+243810231658"
    // },
  ];
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        //${e['titre']}
        // leading: IconButton(
        //   onPressed: () {
        //     //
        //     Get.back();
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.white,
        //   ),
        // ),
        title: Text(
          "Contacts",
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
                  child: ListView(
                    padding:
                        const EdgeInsets.only(top: 50, left: 10, right: 10),
                    children: List.generate(contacts.length, (index) {
                      //
                      Map contact = contacts[index];
                      //
                      return ListTile(
                        // leading: Container(
                        //   height: 50,
                        //   width: 50,
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey.shade400,
                        //     borderRadius: BorderRadius.circular(25),
                        //   ),
                        // ),
                        title: Text("${contact['nom']}"),
                        subtitle: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "${contact['role']}\n",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              //text: "${contact['phone'] ?? ''}",
                              children: [
                                WidgetSpan(
                                    child: SelectableText(
                                  "${contact['phone'] ?? ''}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ))
                              ],
                            ),
                          ]),
                        ),
                      );
                    }),
                  ),
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
                child: Container(
                  alignment: Alignment.center,
                  height: 70,
                  width: Get.size.width,
                  child: Text(
                    "Contact Us",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    //maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      //fontSize: 17,
                    ),
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
                    children: [],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
