import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_app_clone_coding/common/style/font.dart';
import 'package:music_app_clone_coding/routes/player/music.controller.dart';
import 'package:music_app_clone_coding/routes/player/musicDetail.view.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    final MusicController controller = MusicController.to;
    controller.getMusics();
    controller.musics(controller.musicList);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme:
              const IconThemeData(color: Color.fromRGBO(158, 158, 158, 1)),
          backgroundColor: Colors.black54,
          elevation: 0.0,
          title: const Text(
            '음원 검색',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        // search bar
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF2a2a2a),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: Colors.grey,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          searchSong(value);
                        },
                        controller: textEditingController,
                        style: const TextStyle(color: Colors.grey),
                        cursorColor: Colors.grey,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          labelText: "아티스트, 노래 또는 가사",
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                          hintTextDirection: TextDirection.ltr,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffix: IconButton(
                            icon: const Padding(
                              padding: EdgeInsets.only(top: 12, left: 20),
                              child: Icon(
                                Icons.clear,
                                color: Colors.grey,
                              ),
                            ),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              textEditingController.clear();
                              controller.musics(controller.musicList);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // music lists
              Obx(() {
                return Expanded(
                  child: FutureBuilder(
                      future:
                          rootBundle.loadString(controller.musics.toString()),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            itemCount: controller.musics.length,
                            itemBuilder: (context, index) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return const CircularProgressIndicator();
                              } else if (controller.musics.isEmpty) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 50),
                                    child: Text(
                                      "등록된 노래가 없습니다",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 10, 0, 0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MusicDetailView(
                                                tag:
                                                    controller.musics[index].no,
                                                title: controller
                                                    .musics[index].title,
                                                singer: controller
                                                    .musics[index].singer,
                                                composer: controller
                                                    .musics[index].composer,
                                                lyricist: controller
                                                    .musics[index].lyricist,
                                                release: controller
                                                    .musics[index].release,
                                              ),
                                              fullscreenDialog: true,
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: controller.musics[index].no,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 8),
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/album.png'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      SizedBox(
                                        width: 185,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.musics[index].title,
                                                style: MyFontFamily.subTitle,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                controller.musics[index].singer,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 35),
                                      IconButton(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.play_arrow,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Icon(
                                          Icons.more_vert,
                                          size: 33,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            });
                      }),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void searchSong(String title) {
    final MusicController controller = MusicController.to;

    final searchedSong = controller.musicList.where((song) {
      final songTitle = song.title.toLowerCase();
      final input = title.toLowerCase();
      return songTitle.contains(input);
    }).toList();

    controller.musics(searchedSong);
  }
}
