import 'package:flutter/material.dart';
import 'package:music_app_clone_coding/routes/player/player.controller.dart';

class LyricsView extends StatelessWidget {
  const LyricsView({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerController controller = PlayerController.to;
    controller.getPlayerMusics();
    controller.timeStampList();

    final ScrollController scrollController =
        ScrollController(keepScrollOffset: true);

    // GlobalKey 생성
    List<GlobalKey> firstKeys = [];
    void initState() {
      firstKeys =
          List.generate(controller.lyricsList.length, (index) => GlobalKey());
    }

    initState();

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
                      final items = controller.playerMusic.value!.lyrics
                          .replaceAll(RegExp(r'\[[^\]]+\]'), '')
                          .split('\n');

                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          if (isCurrentLyric(controller.timeList, index)) {
                            if (firstKeys[index].currentContext != null) {
                              Scrollable.ensureVisible(
                                firstKeys[index].currentContext!,
                                alignment: 0.3,
                                duration: const Duration(milliseconds: 350),
                              );
                            }
                          }

                          return GestureDetector(
                            key: firstKeys[index],
                            child: Text(
                              items[index],
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
                            ),
                          );
                        },
                        controller: scrollController,
                      );
                    }),
              ),
            )
          : const SizedBox(),
    );
  }

  bool isCurrentLyric(List timestamp, int index) {
    PlayerController playerController = PlayerController.to;

    Duration position = playerController.position.value; // player의 현재 position값
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
