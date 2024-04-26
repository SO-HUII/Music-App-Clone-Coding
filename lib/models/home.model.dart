class HomeModel {
  final String title, singer;

  HomeModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        singer = json['singer'];
}
