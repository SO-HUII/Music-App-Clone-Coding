import 'package:get/get.dart';
import 'package:music_app_clone_coding/models/player.model.dart';
import 'package:music_app_clone_coding/repository/player.repository.dart';

class PlayerController extends GetxController {
  static PlayerController get to => Get.find();

  final PlayerRepository _playerRepository = PlayerRepository();

  init() async {
    await getPlayerMusics();
  }

  RxList<PlayerModel> playerSongList = <PlayerModel>[].obs;

  getPlayerMusics() async {
    final data = await _playerRepository.getPlyerSongs();
    playerSongList([]);

    if (data != null && data.isNotEmpty) {
      final result = data.map<PlayerModel>((e) => PlayerModel.fromJson(e));
      playerSongList.addAll(result);
    }
  }
}
