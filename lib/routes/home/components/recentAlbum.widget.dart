import 'package:flutter/material.dart';
import 'package:music_app_clone_coding/api/api_service.dart';
import 'package:music_app_clone_coding/common/style/font.dart';
import 'package:music_app_clone_coding/models/home.model.dart';

class RecentAlbum extends StatelessWidget {
  RecentAlbum({super.key});

  final Future<List<HomeModel>> songs = ApiService.getSongs();

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
                "최신 앨범",
                style: MyFontFamily.subTitle,
              ),
              Text(
                "더보기",
                style: MyFontFamily.detailTitle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: FutureBuilder(
            future: songs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final song = snapshot.data![index + 6];
                    return Container(
                      width: 150,
                      margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.lightGreen,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            song.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            song.singer,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                        ],
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
