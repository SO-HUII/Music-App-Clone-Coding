import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_app_clone_coding/models/home.model.dart';

class ApiService {
  static const String baseUrl = "https://api.manana.kr/karaoke.json";

  static Future<List<HomeModel>> getSongs() async {
    List<HomeModel> songInstances = [];
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> songLists = jsonDecode(response.body);

      for (var songs in songLists) {
        songInstances.add(HomeModel.fromJson(songs));
      }
      return songInstances;
    }
    throw Error();
  }
}
