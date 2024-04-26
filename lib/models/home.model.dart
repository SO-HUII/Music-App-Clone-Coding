class HomeModel {
  final String no, title, singer;

  HomeModel.fromJson(Map<String, dynamic> json)
      : no = json['no'],
        title = json['title'],
        singer = json['singer'];
}
