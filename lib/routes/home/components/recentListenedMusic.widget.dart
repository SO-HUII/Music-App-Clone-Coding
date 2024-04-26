import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_clone_coding/api/api_service.dart';
import 'package:music_app_clone_coding/common/style/font.dart';
import 'package:music_app_clone_coding/models/home.model.dart';

List<Map<String, String>> songLists = [
  {"Mtitle": "다시 만난 세계", "Msinger": "소녀시대"},
  {"Mtitle": "LOVE DIVE", "Msinger": "IVE"},
  {"Mtitle": "Afer Like", "Msinger": "IVE"},
  {"Mtitle": "Loveable", "Msinger": "조유리"},
  {"Mtitle": "널 제외한 나의 뇌", "Msinger": "DAY6"},
];

class RecentListenedMusic extends StatefulWidget {
  const RecentListenedMusic({super.key});

  @override
  State<RecentListenedMusic> createState() => _RecentListenedMusicState();
}

class _RecentListenedMusicState extends State<RecentListenedMusic> {
  late RxBool padEndsValue = false.obs;
  final Future<List<HomeModel>> songs = ApiService.getSongs();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController recentSongsController =
        PageController(initialPage: 0, viewportFraction: 0.8);

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
          child: FutureBuilder(
            future: songs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PageView.builder(
                  controller: recentSongsController,
                  itemCount: 5,
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
                    final song = snapshot.data![index];
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
                                      song.title,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      song.singer,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0x4DFFFFFF),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
