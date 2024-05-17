import 'package:flutter/material.dart';
import 'package:music_app_clone_coding/common/style/color.dart';
import 'package:music_app_clone_coding/common/style/font.dart';

final imagePathList = [
  'assets/images/singers/singer.png',
  'assets/images/singers/singer1.png',
  'assets/images/singers/singer2.png',
  'assets/images/singers/singer3.png',
];

class RecommendPlayList extends StatelessWidget {
  const RecommendPlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "소제목",
                style: TextStyle(
                  fontSize: 11,
                  color: MyColorFamily.main,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(imagePathList[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "타이틀",
                style: MyFontFamily.subTitle,
              ),
              const Text(
                "부제목",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
