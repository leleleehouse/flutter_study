//평범한 다트 클래스를 만들거임\
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = 'today';
  // url을 받기 위해서는 http패키지를 설치해야한다.
  // flutter나 dart 패키지를 찾고 싶으면 pub.dev 를 이용하면 된다.
  // 보통 pubspec.yaml에 패키지를 추가하고 flutter pub get을 실행하면 된다.
  // pubspec.yaml은 프로젝트에 대한 정보를 가지고 있다.

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(
      url,
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
        'Referer': 'https://comic.naver.com' // 네이버 웹툰 원래 사이트의 Referer 추가
      },
    ); // 이 함수의 이름은 구체적이지 못함

    // get 요청을 보내는 방법: http.get을 사용하고 uri타입을 매개변수로 전달해야함
    // http.get은 Future를 반환한다. Future는 미래에 받을 값의 타입을 알려준다.
    // API 요청이 처리돼서 응답을 반환할 때까지 기다림 -> await를 붙인다 -> 비동기 함수에서만 실행이 가능 -> async를 붙인다.
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      // jsonDecode는 JSON을 Map으로 바꾸어주는 함수이다.
      // jsonDecode는 dynamic을 반환한다. dynamic은 모든 타입을 받을 수 있다.
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error();

    // 이제 우리는 서버로부터 받는 이 JSON 형식의 데이터를 클래스로 바꾸어주어야한다.
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes/latest");

    final response = await http.get(
      url,
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
        'Referer': 'https://comic.naver.com' // 네이버 웹툰 원래 사이트의 Referer 추가
      },
    );

    // Debugging code
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    } else {
      print("Failed to load episodes: ${response.statusCode}");
      throw Exception("에피소드 데이터를 불러올 수 없습니다.");
    }
  }
}
