import 'package:get/get.dart';
import 'package:music_app_clone_coding/models/player.model.dart';
import 'package:music_app_clone_coding/repository/player.repository.dart';

class PlayerController extends GetxController {
  static PlayerController get to => Get.find();

  final PlayerRepository _playerRepository = PlayerRepository();

  init() async {
    await getPlayerMusics();
  }

  Rxn<PlayerModel> playerMusic = Rxn<PlayerModel>();

  getPlayerMusics() async {
    final data = await _playerRepository.getPlayerSongs();

    if (data != null && data.isNotEmpty) {
      final result = PlayerModel.fromJson(data);
      playerMusic(result);
    }
  }

  RxBool isPlaying = false.obs;
  Rx<Duration> duration = const Duration().obs;
  Rx<Duration> position = const Duration().obs;

  pauseMusic() async {
    isPlaying.value = false;
  }
}
