import 'package:flutter/material.dart';
import 'package:music_app_clone_coding/common/style/font.dart';

List<Map<String, String>> songLists = [
  {"Mtitle": "다시 만난 세계", "Msinger": "소녀시대"},
  {"Mtitle": "LOVE DIVE", "Msinger": "IVE"},
  {"Mtitle": "Afer Like", "Msinger": "IVE"},
  {"Mtitle": "Loveable", "Msinger": "조유리"},
  {"Mtitle": "널 제외한 나의 뇌", "Msinger": "DAY6"},
];

class RecentListenedMusic extends StatelessWidget {
  const RecentListenedMusic({super.key});

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
                "최근 들은 노래",
                style: MyFontFamily.subTitle,
              ),
              Text(
                "더보기",
                style: MyFontFamily.detailTitle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 350,
          child: Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  width: 310,
                  height: 250,
                  margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: songLists.map((songList) {
                      return Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.lightBlue,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  songList['Mtitle'] as String,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  songList['Msinger'] as String,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0x4DFFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
