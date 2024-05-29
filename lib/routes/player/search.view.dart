import 'package:flutter/material.dart';
import 'package:music_app_clone_coding/api/api_service.dart';
import 'package:music_app_clone_coding/common/style/font.dart';
import 'package:music_app_clone_coding/models/home.model.dart';
import 'package:music_app_clone_coding/routes/home/components/recentListenedMusic.widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  //final PlayerController controller = PlayerController.to;
  final Future<List<HomeModel>> songs = ApiService.getSongs();
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.grey),
          backgroundColor: Colors.black54,
          elevation: 0.0,
          title: const Text(
            '음원 검색',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
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
                              if (textEditingController.value ==
                                  TextEditingValue.empty) {
                                // 올라온 키보드 끄기
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                              textEditingController.value =
                                  TextEditingValue.empty;
                              songLists;
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
              Expanded(
                child: FutureBuilder(
                    future: songs,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: songLists.length,
                          itemBuilder: (context, index) {
                            final song = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
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
                                            song.title,
                                            style: MyFontFamily.subTitle,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            song.singer,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 35),
                                  IconButton(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    onPressed: () {},
                                    icon: const Icon(
                                      // controller.isPlaying.value
                                      //     ? Icons.pause
                                      //     : Icons.play_arrow,
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
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchSong(String title) {
    final search = songLists.where((song) {
      final songTitle = song['title']?.toLowerCase() ?? '';
      final input = title.toLowerCase();

      return songTitle.contains(input);
    }).toList();

    setState(() {
      songLists = search;
    });
    print("제목!!!! ${title}");
  }
}
