import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_clone_coding/common/style/font.dart';

final imagePathList = [
  'assets/images/singers/singer.png',
  'assets/images/singers/singer1.png',
  'assets/images/singers/singer2.png',
  'assets/images/singers/singer3.png',
];

class Magazine extends StatefulWidget {
  const Magazine({super.key});

  @override
  State<Magazine> createState() => _MagazineState();
}

class _MagazineState extends State<Magazine> {
  late RxBool padEndsValue = false.obs;

  @override
  Widget build(BuildContext context) {
    final PageController magazineController =
        PageController(initialPage: 0, viewportFraction: 0.85);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "매거진",
                style: MyFontFamily.subTitle,
              ),
              Text(
                "더보기",
                style: MyFontFamily.detailTitle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: magazineController,
            itemCount: 4,
            padEnds: padEndsValue(),
            onPageChanged: (index) {
              if (index != 0 && index != 3) {
                padEndsValue(true);
              } else {
                padEndsValue(false);
              }
              setState(() {});
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      height: 300,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: AssetImage(imagePathList[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.deepPurple,
                            ),
                            width: 70,
                            height: 25,
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'GENRE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "이주의 디깅 #181 \n비욘세",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
