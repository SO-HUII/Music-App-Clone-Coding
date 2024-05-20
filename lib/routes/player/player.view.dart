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
    audioPlayer.onDurationChanged.listen((newDuration) {
      controller.duration = newDuration;
    });

    // listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) {
      controller.position = newPosition;
    });

    // Future setAudio() async {
    //   // repeat song when completed
    //   audioPlayer.setReleaseMode(ReleaseMode.loop);

    //   String url = controller.playerMusic.value!.file;
    //   audioPlayer.setSourceUrl(url);
    // }

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
              const Text(""),
              const SizedBox(height: 15),
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
                data: SliderThemeData(
                  //thumbShape: SliderComponentShape.noThumb,
                  trackHeight: 2,
                  inactiveTrackColor: Colors.grey,
                ),
                child: Slider(
                  min: 0.0,
                  max: controller.duration.inSeconds.toDouble(),
                  value: controller.position.inSeconds.toDouble(),
                  thumbColor: MyColorFamily.main,
                  onChanged: (value) async {
                    controller.position = Duration(seconds: value.toInt());
                    await audioPlayer.seek(controller.position);
                    await audioPlayer.resume(); // play audio if was paused
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${controller.position.inMinutes.remainder(60).toString().padLeft(1, '0')}:${(controller.position.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '${controller.duration.inMinutes.remainder(60).toString().padLeft(1, '0')}:${(controller.duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.repeat_rounded,
                    size: 23,
                    color: Colors.grey,
                  ),
                  const Icon(
                    Icons.skip_previous_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                  // play & pause button
                  IconButton(
                    onPressed: () async {
                      if (controller.isPlaying.value) {
                        await audioPlayer.pause();
                        print("야");
                      } else {
                        // await audioPlayer.resume();
                        await audioPlayer.play(
                            UrlSource(controller.playerMusic.value!.file));
                        print("왜");
                      }
                      //setAudio();
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
                  const Icon(
                    Icons.skip_next_rounded,
                    size: 50,
                    color: Colors.white,
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
