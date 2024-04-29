import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app_clone_coding/common/style/font.dart';

List<Map<String, String>> partyRoomItems = [
  {"image": "", "title": "", "manager": ""},
  {
    "image": "assets/images/singers/singer.png",
    "title": "마이데이 모여",
    "manager": "강영현"
  },
  {
    "image": "assets/images/singers/singer1.png",
    "title": "아이브 플리",
    "manager": "안유진"
  },
  {
    "image": "assets/images/singers/singer2.png",
    "title": "하입보이",
    "manager": "김민지"
  },
  {
    "image": "assets/images/singers/singer3.png",
    "title": "테일러 스위프트 방",
    "manager": "다니엘"
  },
];

class PartyRoomWidget extends StatefulWidget {
  const PartyRoomWidget({super.key});

  @override
  State<PartyRoomWidget> createState() => _PartyRoomWidgetState();
}

class _PartyRoomWidgetState extends State<PartyRoomWidget> {
  var isPick = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "나를 위한 파티룸",
              style: MyFontFamily.subTitle,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2a2a2a),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Ink(
                      decoration: BoxDecoration(
                        color: isPick ? Colors.black : const Color(0xFF2a2a2a),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isPick = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          child: Text(
                            "PICK",
                            style: TextStyle(
                              fontSize: 10,
                              color: isPick ? Colors.white : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Ink(
                      decoration: BoxDecoration(
                        color: isPick ? const Color(0xFF2a2a2a) : Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isPick = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          child: Text(
                            "MY",
                            style: TextStyle(
                              fontSize: 10,
                              color: isPick ? Colors.grey : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        isPick
            ? SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: partyRoomItems.length,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xFF424242)),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: 200,
                              height: 60,
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2a2a2a),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 1,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        partyRoomItems[index]['image']!,
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          partyRoomItems[index]['title']!,
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: const TextStyle(
                                            fontSize: 12.5,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          partyRoomItems[index]['manager']!,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF2a2a2a),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 13,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "다양한 이야기와 음악이 만나는 곳",
                          style: MyFontFamily.detailTitle,
                        ),
                        Text(
                          "파티룸을 시작해 보세요!",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 65),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 77, 76, 76),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 6,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                          Text(
                            "시작하기",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          SizedBox(width: 2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
