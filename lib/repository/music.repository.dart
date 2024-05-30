import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MusicRepository {
  final dio = Dio();

  Future<List<dynamic>> getMusics() async {
    try {
      final response = await dio.get(
        'https://api.manana.kr/karaoke.json',
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print('getMusics statusCode: ${e.response!.statusCode}');
        print('getMusics data: ${e.response!.data}');
      } else {
        printError();
      }
    }
    return [];
  }
}
