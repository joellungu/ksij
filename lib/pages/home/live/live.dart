import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ksij_kinshasa/pages/home/evenements/evenement_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Live extends StatelessWidget {
  //
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'l8PMl7tUDIE',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    //
    return Expanded(
      flex: 1,
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        //videoProgressIndicatorColor: Colors.amber,
      ),
    );
  }
}
