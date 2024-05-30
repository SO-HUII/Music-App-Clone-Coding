class MusicModel {
  final String brand, no, title, singer, composer, lyricist, release;

  MusicModel.fromJson(Map<String, dynamic> json)
      : brand = json['brand'],
        no = json['no'],
        title = json['title'],
        singer = json['singer'],
        composer = json['composer'],
        lyricist = json['lyricist'],
        release = json['release'];
}