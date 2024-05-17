class PlayerModel {
  String singer, album, title, image, file, lyrics;
  int duration;

  PlayerModel.fromJson(Map<String, dynamic> json)
      : singer = json['singer'],
        album = json['album'],
        title = json['title'],
        duration = json['duration'],
        image = json['image'],
        file = json['file'],
        lyrics = json['lyrics'];
}
