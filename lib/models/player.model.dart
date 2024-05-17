class PlayerModel {
  final String singer, album, title, duration, image, file, lyrics;

  PlayerModel.fromJson(Map<String, dynamic> json)
      : singer = json['singer'],
        album = json['album'],
        title = json['title'],
        duration = json['duration'],
        image = json['image'],
        file = json['file'],
        lyrics = json['lyrics'];
}
