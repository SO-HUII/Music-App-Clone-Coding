import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:music_app_clone_coding/common/style/color.dart';
import 'package:music_app_clone_coding/routes/player/player.controller.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayer();

    final PlayerController controller = PlayerController();
    controller.getPlayerMusics();

    // listen to states: playing, paused, stopped
    audioPlayer.onPlayerStateChanged.listen((state) {
      controller.isPlaying.value = state == PlayerState.playing;
    });

    // listen to audio duration
    audioPlayer.onDurationChanged.listen((Duration newDuration) {
      controller.duration(newDuration);
    });

    // listen to audio position
    audioPlayer.onPositionChanged.listen((Duration newPosition) {
      controller.position(newPosition);
    });

    audioPlayer.onPlayerComplete.listen((_) {
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
      body: SingleChildScrollView(
        child: Container(
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
                      image: NetworkImage(
                          controller.playerMusic.value?.image ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
              const SizedBox(height: 40),
              SingleChildScrollView(
                child: Obx(() {
                  return Text(
                    controller.playerMusic.value?.lyrics ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),
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
                  const Icon(
                    Icons.favorite_border,
                    size: 23,
                    color: Colors.grey,
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
                      await audioPlayer.seek(Duration(seconds: value.toInt()));
                      await audioPlayer.resume(); // play audio if was paused
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
                        // (controller.duration.value - controller.position.value)
                        //     .toString(),
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
                      audioPlayer.seek(Duration(
                          seconds: controller.position.value.inSeconds - 10));
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
                        await audioPlayer.pause();
                      } else {
                        // await audioPlayer.resume();
                        await audioPlayer.play(
                            UrlSource(controller.playerMusic.value!.file));
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
                  // // +10 seconds
                  IconButton(
                    onPressed: () {
                      audioPlayer.seek(Duration(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
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
      ),
    );
  }
}
