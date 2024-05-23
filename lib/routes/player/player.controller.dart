import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/state_manager.dart';
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
  Rx<AudioPlayer> audioPlayer = AudioPlayer().obs;
  Rx<Duration> duration = const Duration().obs;
  Rx<Duration> position = const Duration().obs;

  pauseMusic() async {
    isPlaying.value = false;
  }

  RxInt selectedIndex = 1.obs;

  RxList<String> lyricsList = <String>[].obs; // 가사 리스트
  RxList<Duration> timeList = <Duration>[].obs; // 가사에서 추출한 타임 스탬프 리스트

  timeStampList() async {
    lyricsList =
        playerMusic.value?.lyrics.split('\n').toList().obs ?? <String>[].obs;

    for (String lyric in lyricsList) {
      String timeStamp = lyric.split(']')[0].substring(1);

      List<String> time = timeStamp.split(':');
      int hour = int.parse(time[0]);
      int minute = int.parse(time[1]);
      int second = int.parse(time[2]);

      Duration dTime = Duration(hours: hour, minutes: minute, seconds: second);
      timeList.add(dTime);
    }
  }
}
