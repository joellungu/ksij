import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:ksij_kinshasa/pages/home/evenements/evenement_controller.dart';
import 'package:ksij_kinshasa/utils/langi.dart';

class Evenements extends GetView<EvenementController> {
  @override
  Widget build(BuildContext context) {
    //
    return FutureBuilder(
      future: controller.allEvents(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List cards = snapshot.data!;
          return Center(
            child: Container(
              height: 70,
              width: Get.size.width,
              // child: ListView(
              //   scrollDirection: Axis.horizontal,
              //   children: List.generate(cards.length, (index) {
              //     Map card = cards[index];
              //     print("card: $card");
              //     return Container(
              //       height: 70,
              //       width: Get.size.width / 1.2,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Colors.black),
              //       ),
              //       child: ListTile(
              //         title: Text("${card['titre']}"),
              //         subtitle: Text(
              //           "${card['contenu']}",
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 2,
              //         ),
              //       ),
              //     );
              //   }),
              // ),
            ),
          );
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
    );
  }
}
