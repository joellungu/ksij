import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:ksij_kinshasa/utils/langi.dart';
import 'actualite_controller.dart';

class Actualite extends GetView<ActualiteController> {
  //
  // List<Widget> cards = [
  //   Card(
  //     //
  //     elevation: 3,
  //     //padding: EdgeInsets.all(5),
  //     //color: Colors.teal,
  //     child: Container(
  //       alignment: Alignment.center,
  //       child: const Text('1'),
  //       decoration: BoxDecoration(
  //           color: Colors.blue, borderRadius: BorderRadius.circular(20)),
  //     ),
  //   ),
  //   Card(
  //     //
  //     elevation: 3,
  //     //padding: EdgeInsets.all(5),
  //     //color: Colors.teal,
  //     child: Container(
  //       alignment: Alignment.center,
  //       child: const Text('2'),
  //       decoration: BoxDecoration(
  //           color: Colors.red, borderRadius: BorderRadius.circular(20)),
  //     ),
  //   ),
  //   Card(
  //     //
  //     elevation: 3,
  //     color: Colors.white,
  //     //padding: EdgeInsets.all(5),
  //     //color: Colors.teal,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //     child: Container(
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         color: Colors.transparent,
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           Expanded(
  //             flex: 7,
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(20),
  //                 gradient: LinearGradient(
  //                   begin: Alignment.bottomCenter,
  //                   end: Alignment.topCenter,
  //                   colors: <Color>[
  //                     Langi.base4,
  //                     Langi.base3,
  //                     Langi.base2,
  //                     Langi.base1,
  //                   ],
  //                 ),
  //               ),
  //               child: const Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Align(
  //                     alignment: Alignment.topCenter,
  //                     child: Text(
  //                       "Fete nationale de martyre",
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 30,
  //                       ),
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       "Gagnez de nombreux prix en participant aux Challenges",
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 20,
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             flex: 2,
  //             child: Container(
  //               child: Align(
  //                 alignment: Alignment.center,
  //                 child: Text(
  //                   "12 Oct. 2023",
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 17,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  // ];

  Actualite({super.key}) {
    //controller.allEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      body: FutureBuilder(
        future: controller.allEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List cards = snapshot.data!;
            return Center(
                child: Container(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(cards.length, (index) {
                  Map card = cards[index];
                  print("card: $card");
                  return Container(
                    height: 70,
                    width: Get.size.width / 1.2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: ListTile(
                      title: Text("${card['titre']}"),
                      subtitle: Text(
                        "${card['contenu']}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  );
                }),
              ),
            ));
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
    );
  }
}
