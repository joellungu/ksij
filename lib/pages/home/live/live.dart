import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ksij_kinshasa/pages/home/evenements/evenement_controller.dart';
import 'package:ksij_kinshasa/utils/requete.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Live extends StatelessWidget {
  //
  Requete requete = Requete();
  //
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'l8PMl7tUDIE',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: lancer(),
        builder: (c, t) {
          if (t.hasData) {
            //
            Map live = t.data as Map;
            print("le live: $live");
            String url = "${live['lien']}"; //live['lien'];
            //
            return Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (!await launchUrl(Uri.parse(url))) {
                    throw Exception('Could not launch ${Uri.parse(url)}');
                  }
                  // if (Platform.isIOS) {
                  //   if (await canLaunch(
                  //       'youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw')) {
                  //     await launch(
                  //         'youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw');
                  //   } else {
                  //     if (await canLaunch(
                  //         'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw')) {
                  //       await launch(
                  //           'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw');
                  //     } else {
                  //       throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
                  //     }
                  //   }
                  // } else {
                  //   const url =
                  //       'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
                  //   if (await canLaunch(url)) {
                  //     await launch(url);
                  //   } else {
                  //     throw 'Could not launch $url';
                  //   }
                  // }
                },
                child: Text("Launch live / ${live['titre']}"),
              ),
            );
          } else if (t.hasError) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  //
                },
                child: const Text("Reload"),
              ),
            );
          }
          return const Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      // body: Center(
      //   child: YoutubePlayer(
      //     aspectRatio: 1,
      //     controller: _controller,
      //     showVideoProgressIndicator: true,
      //     //videoProgressIndicatorColor: Colors.amber,
      //   ),
      // ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch ${Uri.parse(url)}');
    }
  }

  Future<Map> lancer() async {
    //
    Response response = await requete.getE("live/live");
    if (response.isOk) {
      return response.body;
    } else {
      return {};
    }
  }
}
