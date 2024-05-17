import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PlayerRepository {
  final dio = Dio();
  
  Future<List<dynamic>?> getPlyerSongs() async {
    try {
      final response = await dio.get(
        'https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json',
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print('getPlyerSongs statusCode: ${e.response!.statusCode}');
        print('getPlyerSongs data: ${e.response!.data}');
      } else {
        printError();
      }
    }
    return null;
  }
}
