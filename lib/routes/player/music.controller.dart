import 'package:get/get.dart';
import 'package:music_app_clone_coding/models/music.model.dart';
import 'package:music_app_clone_coding/repository/music.repository.dart';

class MusicController extends GetxController {
  static MusicController get to => Get.find();

  final MusicRepository _musicRepository = MusicRepository();

  init() async {
    await getMusics();
  }

  RxList<MusicModel> musicList = <MusicModel>[].obs;

  getMusics() async {
    final data = await _musicRepository.getMusics();

    musicList.addAll(
      data.map((e) => MusicModel.fromJson(e)).toList(),
    );
  }
}
