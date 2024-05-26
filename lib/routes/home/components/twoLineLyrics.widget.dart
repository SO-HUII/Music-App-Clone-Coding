import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_app_clone_coding/routes/player/player.controller.dart';

class TwoLineLyrics extends StatelessWidget {
  const TwoLineLyrics({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerController controller = PlayerController.to;
    controller.getPlayerMusics();
    controller.timeStampList();

    return FutureBuilder(
        future: rootBundle.loadString(controller.lyricsList.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          } else if (controller.lyricsList.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "등록된 가사가 없습니다",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          } else {
            return Obx(() {
              int index = 0;
              for (int i = 0; i < controller.lyricsList.length; i++) {
                if (isCurrentLyric(controller.timeList, i)) {
                  index = i;
                }
              }
              return Column(
                children: [
                  lyricLine(controller.lyricsList, controller.timeList, index),
                  const SizedBox(height: 4),
                  lyricLine(
                      controller.lyricsList, controller.timeList, index + 1),
                ],
              );
            });
          }
        });
  }

  // 가사 표시 method
  Widget lyricLine(List lyricsList, List timestamp, int index) {
    if (index == lyricsList.length) {
      return const Text('');
    }
    return Center(
      child: Text(
        lyricsList[index].replaceAll(RegExp(r'\[[^\]]+\]'), ''),
        style: TextStyle(
          fontSize: isCurrentLyric(timestamp, index) ? 18 : 16.5,
          fontWeight: isCurrentLyric(timestamp, index)
              ? FontWeight.bold
              : FontWeight.normal,
          color: isCurrentLyric(timestamp, index) ? Colors.white : Colors.grey,
        ),
      ),
    );
  }

  // 현재 position과 time stamp가 일치하는지 판단
  bool isCurrentLyric(List timestamp, int index) {
    PlayerController playerController = PlayerController.to;

    Duration position = playerController.position.value;
    Duration startTime = timestamp[index];
    Duration endTime = timestamp.length == index + 1
        ? playerController.duration.value
        : timestamp[index + 1];

    if (startTime <= position && position < endTime) {
      return true;
    } else {
      return false;
    }
  }
}
