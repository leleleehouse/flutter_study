// "id":"814826","title":"울어 봐, 빌어도 좋고",
// "thumb":"https://image-comic.pstatic.net/webtoon/814826/thumbnail/thumbnail_IMAG21_1de7535f-9088-4f21-8b16-413cb1e66307.jpg"

class WebtoonModel {
  late final String title, thumb, id;
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
  // key는 json의 key이고 value는 json의 body이다.
}
