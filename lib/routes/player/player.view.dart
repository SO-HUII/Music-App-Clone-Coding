import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_clone_coding/common/style/color.dart';
import 'package:music_app_clone_coding/routes/home/components/twoLineLyrics.widget.dart';
import 'package:music_app_clone_coding/routes/player/player.controller.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    //final audioPlayer = AudioPlayer();

    final PlayerController controller = PlayerController.to;
    controller.getPlayerMusics();

    // listen to states: playing, paused, stopped
    controller.audioPlayer.value.onPlayerStateChanged.listen((state) {
      controller.isPlaying.value = state == PlayerState.playing;
    });

    // listen to audio duration
    controller.audioPlayer.value.onDurationChanged
        .listen((Duration newDuration) {
      controller.duration(newDuration);
    });

    // listen to audio position
    controller.audioPlayer.value.onPositionChanged
        .listen((Duration newPosition) {
      controller.position(newPosition);
    });

    controller.audioPlayer.value.onPlayerComplete.listen((_) {
      controller.position = controller.duration;
    });

    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: Colors.black54,
        elevation: 0.0,
        leading: const Icon(Icons.tune),
        actions: const [
          Icon(Icons.send),
          SizedBox(width: 20),
          Icon(Icons.more_horiz),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Obx(() {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                    image:
                        NetworkImage(controller.playerMusic.value?.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
            const SizedBox(height: 35),

            // 가사
            const TwoLineLyrics(),

            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Text(
                        controller.playerMusic.value?.title ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }),
                    Obx(() {
                      return Text(
                        controller.playerMusic.value?.singer ?? '',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }),
                  ],
                ),
                IconButton(
                  onPressed: () async {
                    controller.isLike.value = !controller.isLike.value;
                  },
                  icon: Obx(() {
                    return Icon(
                      controller.isLike.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 23,
                      color: Colors.grey,
                    );
                  }),
                ),
              ],
            ),
            SliderTheme(
              data: const SliderThemeData(
                trackHeight: 2,
                inactiveTrackColor: Colors.grey,
                activeTrackColor: MyColorFamily.main,
              ),
              child: Obx(() {
                return Slider(
                  min: 0.0,
                  max: controller.duration.value.inSeconds.toDouble(),
                  value: controller.position.value.inSeconds.toDouble(),
                  thumbColor: MyColorFamily.main,
                  onChanged: (value) async {
                    await controller.audioPlayer.value
                        .seek(Duration(seconds: value.toInt()));
                    await controller.audioPlayer.value
                        .resume(); // play audio if was paused
                  },
                );
              }),
            ),
            // song duration & position
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return Text(
                      '${controller.position.value.inMinutes.remainder(60).toString().padLeft(1, '0')}:${(controller.position.value.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    );
                  }),
                  Obx(() {
                    return Text(
                      '${(controller.duration.value - controller.position.value).inMinutes.remainder(60).toString().padLeft(1, '0')}:${((controller.duration.value - controller.position.value).inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // play buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.repeat_rounded,
                  size: 23,
                  color: Colors.grey,
                ),
                // -10 seconds
                IconButton(
                  onPressed: () {
                    controller.audioPlayer.value.seek(
                      Duration(
                          seconds: controller.position.value.inSeconds - 10),
                    );
                  },
                  icon: const Icon(
                    Icons.skip_previous_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                // play & pause button
                IconButton(
                  onPressed: () async {
                    if (controller.isPlaying.value) {
                      await controller.audioPlayer.value.pause();
                    } else {
                      await controller.audioPlayer.value
                          .play(UrlSource(controller.playerMusic.value!.file));
                    }
                  },
                  icon: Obx(() {
                    return Icon(
                      controller.isPlaying.value
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 60,
                      color: Colors.white,
                    );
                  }),
                ),
                // +10 seconds
                IconButton(
                  onPressed: () {
                    controller.audioPlayer.value.seek(Duration(
                        seconds: controller.position.value.inSeconds + 10));
                  },
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const Icon(
                  Icons.shuffle_rounded,
                  size: 23,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
      // bottom navigation bar
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: MyColorFamily.main,
          unselectedItemColor: Colors.grey,
          mouseCursor: MouseCursor.defer,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            controller.selectedIndex.value = index;
            if (index == 0) {
              Get.toNamed('/lyrics');
            } else if (index == 1) {
              Get.toNamed('/player');
            }
          },
          currentIndex: controller.selectedIndex.value,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bolt),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.queue_music),
              label: '',
            ),
          ],
        );
      }),
    );
  }

  bool isCurrentLyric(List timestamp, int index) {
    PlayerController playerController = PlayerController.to;
    // player의 현재 position값
    Duration position = playerController.position.value;
    Duration startTime = timestamp[index];
    Duration endTime = timestamp.length == index + 1 // 다음 가사의 타임스탬프 값
        ? playerController.duration.value // player의 현재 duration값
        : timestamp[index + 1];

    if (startTime <= position && position < endTime) {
      // print("시작: ${startTime} 끝: ${endTime}");
      return true;
    } else {
      return false;
    }
  }
}
