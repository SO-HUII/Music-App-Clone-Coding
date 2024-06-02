import 'package:flutter/material.dart';
import 'package:music_app_clone_coding/routes/player/music.controller.dart';

List<String> subTitle = ["발매일", "작곡", "작사"];

class MusicDetailView extends StatelessWidget {
  final String tag, title, singer, composer, lyricist, release;
  const MusicDetailView({
    super.key,
    required this.tag,
    required this.title,
    required this.singer,
    required this.composer,
    required this.lyricist,
    required this.release,
  });

  @override
  Widget build(BuildContext context) {
    final MusicController controller = MusicController.to;
    controller.getMusics();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Icon(
            Icons.close,
            color: Colors.white,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Hero(
        tag: tag,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 35, 0, 10),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage('assets/images/album.png'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              singer,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button("재생하기"),
                const SizedBox(width: 15),
                button("프로필뮤직"),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "상세정보",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.2),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    singer,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    height: 1,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  const SizedBox(height: 5),
                  for (int i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Text(
                            subTitle[i],
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 71, 71, 71),
                            ),
                          ),
                          const SizedBox(width: 20),
                          detailText(i),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 버튼 위젯
  Widget button(String name) {
    return SizedBox(
      width: 120,
      child: OutlinedButton(
        onPressed: () {},
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 22, vertical: 3),
          ),
          side: WidgetStateProperty.all(
            const BorderSide(
              color: Colors.grey,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            name == "재생하기"
                ? const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.green,
                  )
                : Container(),
            Text(
              name,
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 노래 상세 정보 위젯
  Widget detailText(i) {
    switch (i) {
      case 0:
        return Text(
          release,
          style: const TextStyle(color: Colors.black, fontSize: 13),
        );
      case 1:
        return Text(
          composer,
          style: const TextStyle(color: Colors.black, fontSize: 13),
        );
      case 2:
        return Text(
          lyricist,
          style: const TextStyle(color: Colors.black, fontSize: 13),
        );
      default:
        return const Text("");
    }
  }
}
