import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_clone_coding/routes/player/player.controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LyricsView extends StatelessWidget {
  const LyricsView({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerController controller = PlayerController.to;
    controller.getPlayerMusics();
    controller.timeStampList();

    final ItemScrollController itemScrollController = ItemScrollController();
    final ScrollOffsetController scrollOffsetController =
        ScrollOffsetController();
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();
    final ScrollOffsetListener scrollOffsetListener =
        ScrollOffsetListener.create();
    // StreamSubscription? streamSubscription;
    //
    // void init() {
    //   streamSubscription = audioPlayer.onPositionChanged.listen((duration) {
    //     DateTime dt = DateTime(2000, 1, 1).copyWith(
    //       hour: duration.inHours,
    //       minute: duration.inMinutes.remainder(60),
    //       second: duration.inSeconds.remainder(60),
    //     );
    //     print("dt: ${dt}");
    //     if (controller.timeList.isNotEmpty) {
    //       for (int index = 0; index < controller.timeList.length; index++) {
    //         if (index > 4 &&
    //             DateTime.parse(controller.position.toString()).isAfter(dt)) {
    //           itemScrollController.scrollTo(
    //               index: index - 3,
    //               duration: const Duration(milliseconds: 600));
    //           break;
    //         }
    //       }
    //     }
    //   });
    // }

    // init();

    return Scaffold(
      backgroundColor: Colors.black54,
      body: controller.playerMusic.value?.lyrics != null
          ? SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0)
                    .copyWith(top: 20),
                child: StreamBuilder(
                    stream: controller.audioPlayer.value.onPositionChanged,
                    builder: (context, snapshot) {
                      return ScrollablePositionedList.builder(
                        itemCount: controller.playerMusic.value!.lyrics
                            .split('\n')
                            .toList()
                            .length,
                        itemBuilder: (context, index) {
                          return Obx(() {
                            return Text(
                              controller.playerMusic.value!.lyrics
                                  .replaceAll(RegExp(r'\[[^\]]+\]'), '')
                                  .split('\n')
                                  .toList()[index],
                              style: TextStyle(
                                color:
                                    isCurrentLyric(controller.timeList, index)
                                        ? Colors.white
                                        : Colors.grey,
                                fontSize:
                                    isCurrentLyric(controller.timeList, index)
                                        ? 18
                                        : 16,
                              ),
                            );
                          });
                        },
                        itemScrollController: itemScrollController,
                        scrollOffsetController: scrollOffsetController,
                        itemPositionsListener: itemPositionsListener,
                        scrollOffsetListener: scrollOffsetListener,
                      );
                    }),
              ),
            )
          : const SizedBox(),
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
      return true;
    } else {
      return false;
    }
  }
}
