import 'package:flutter/material.dart';
import 'package:music_app_clone_coding/routes/home/components/homeHeader.widget.dart';
import 'package:music_app_clone_coding/routes/home/components/partyRoom.widget.dart';
import 'package:music_app_clone_coding/routes/home/components/recommendPlayList.widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Column(
            children: <Widget>[
              HomeHeader(),
              SizedBox(height: 30),
              PartyRoomWidget(),
              SizedBox(height: 30),
              RecommendPlayList(),
            ],
          ),
        ),
      ),
    );
  }
}
