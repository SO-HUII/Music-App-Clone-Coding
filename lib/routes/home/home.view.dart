import 'package:flutter/material.dart';
import 'package:music_app_clone_coding/common/style/color.dart';
import 'package:music_app_clone_coding/routes/home/components/homeHeader.widget.dart';
import 'package:music_app_clone_coding/routes/home/components/magazine.widget.dart';
import 'package:music_app_clone_coding/routes/home/components/mixtape.widget.dart';
import 'package:music_app_clone_coding/routes/home/components/partyRoom.widget.dart';
import 'package:music_app_clone_coding/routes/home/components/recentAlbum.widget.dart';
import 'package:music_app_clone_coding/routes/home/components/recentListenedMusic.widget.dart';
import 'package:music_app_clone_coding/routes/home/components/recommendPlayList.widget.dart';
import 'package:music_app_clone_coding/routes/home/components/smallPlayer.widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Column(
                    children: <Widget>[
                      const HomeHeader(),
                      const SizedBox(height: 30),
                      const PartyRoomWidget(),
                      const SizedBox(height: 30),
                      const RecommendPlayList(),
                      const MixTape(),
                      const SizedBox(height: 35),
                      const RecentListenedMusic(),
                      const SizedBox(height: 30),
                      RecentAlbum(),
                      const SizedBox(height: 40),
                      const Magazine(),
                    ],
                  ),
                ),
              ),
            ),
            const SmallPlayer(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: MyColorFamily.main,
          unselectedItemColor: Colors.grey.withOpacity(.60),
          selectedLabelStyle:
              const TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
          unselectedLabelStyle:
              const TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.interests),
              label: '투데이',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined),
              label: '차트',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.album),
              label: '오디오',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.queue_music),
              label: '재생목록',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '보관함',
            ),
          ],
        ),
      ),
    );
  }
}
