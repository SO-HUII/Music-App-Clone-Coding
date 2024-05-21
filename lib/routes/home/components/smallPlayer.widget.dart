import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:music_app_clone_coding/common/style/font.dart';
import 'package:music_app_clone_coding/routes/player/player.controller.dart';

class SmallPlayer extends StatelessWidget {
  const SmallPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerController controller = PlayerController();
    controller.getPlayerMusics();
    controller.pauseMusic();

    return Container(
      height: 65,
      padding: const EdgeInsets.fromLTRB(15, 9, 15, 0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 17, 16, 16),
      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/player');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image:
                        NetworkImage(controller.playerMusic.value?.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
            const SizedBox(width: 15),
            SizedBox(
              width: 185,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return Text(
                      controller.playerMusic.value?.title ?? '',
                      style: MyFontFamily.subTitle,
                      overflow: TextOverflow.ellipsis,
                    );
                  }),
                  Obx(() {
                    return Text(
                      controller.playerMusic.value?.singer ?? '',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }),
                ],
              ),
            ),
            Obx(() {
              return IconButton(
                  padding: const EdgeInsets.only(bottom: 10),
                  onPressed: () {
                    controller.isPlaying.value = !controller.isPlaying.value;
                  },
                  icon: controller.isPlaying.value
                      ? const Icon(
                          Icons.pause,
                          size: 35,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.play_arrow,
                          size: 35,
                          color: Colors.white,
                        ));
            }),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Icon(
                Icons.skip_next,
                size: 33,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Icon(
                Icons.queue_music,
                size: 23,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
