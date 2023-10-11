import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'actualite_controller.dart';

class Actualite extends GetView<ActualiteController> {
  @override
  Widget build(BuildContext context) {
    //
    return ListView(
      padding: const EdgeInsets.all(10),
      children: List.generate(10, (index) {
        return Card(
          elevation: 1,
          child: InkWell(
            onTap: () {
              //
              //Get.to(DetailsTest());
              //
            },
            child: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      child: ListTile(
                        // leading: Container(
                        //   height: 50,
                        //   width: 50,
                        //   alignment: Alignment.center,
                        //   child: Icon(
                        //     CupertinoIcons.person,
                        //     color: Colors.black,
                        //     size: 35,
                        //   ),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(25),
                        //       color: Colors.deepPurple.shade100
                        //           .withOpacity(0.7)),
                        // ),
                        title: Text(
                          "Fete nationale de martyre",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        subtitle: Text(
                          "Gagnez de nombreux prix en participant aux Challenges",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                    width: double.maxFinite,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Corporation",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: index % 2 == 2
                                        ? Colors.red
                                        : index % 2 == 1
                                            ? Colors.green
                                            : Colors.yellow.shade900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "10 Jan, 2023",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
