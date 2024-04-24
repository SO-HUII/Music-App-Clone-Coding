import 'package:flutter/material.dart';
import 'package:music_app_clone_coding/routes/home/components/homeHeader.widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const HomeHeader();
  }
}
