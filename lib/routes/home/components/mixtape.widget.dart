import 'package:flutter/material.dart';
import 'package:music_app_clone_coding/common/style/font.dart';

final imagePathList = [
  'assets/images/singers/singer.png',
  'assets/images/singers/singer1.png',
  'assets/images/singers/singer2.png',
  'assets/images/singers/singer3.png',
];

class MixTape extends StatelessWidget {
  const MixTape({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "나를 위한 믹스테잎",
                style: MyFontFamily.subTitle,
              ),
              Text(
                "더보기",
                style: MyFontFamily.detailTitle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 230,
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      height: 170,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2a2a2a),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "아티스트",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "Mix",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0x4DFFFFFF),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                image: AssetImage(imagePathList[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "아이브, aespa, 스테이씨, 르세라핌, 있지",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Color(0x4DFFFFFF),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
