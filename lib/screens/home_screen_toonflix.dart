import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';
// 먼저 initState 는 build 메소드가 호출이 되기전에 한번 호출됩니다.
// initState 안에 waitForWebtoon 메소드 호출하게 되면서
// Future 객체를 미리 반환하고 기다립니다.
// 이때 Future 객체는 아직 실제 데이터가 도착안했으니
// build 메소드를 바로 실행합니다.
// 후에 데이터가 문제없이 전달되면
// 그때서야 isLoading = false 와 setState 을 호출하게 됩니다.
// 그리고 setState 을 호출했기에 build 메소드를 자동 호출하게 되며 re-render 가 됩니다.

// 정리하자면,
// 1. initState
// 2. waitForWebtoons
// 3. ApiService.getTodaysToons
// 4. build
// 5. 데이터 도착
// 6. isLoading = false
// 7. setState
// 8. build

class HomeScreenToonflix extends StatelessWidget {
  HomeScreenToonflix({super.key});
  //const는 컴파일 전에 값을 알고 있다는 뜻

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          title: Text(
            'Toonflix',
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: FutureBuilder(
          future: webtoons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // 데이터가 많을때는 ListView를 쓰는게 좋다. 여러항목을 나열하는데 최적화된 위젯이다.
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: makeList(snapshot),
                  ),
                ],
              );
            }
            //snapshot은 future의 상태이다.
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      //ListView.builder는 ListView보다 좀 더 최적화된 ListView이다.
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        //사용자가 보고있는 아이템만 빌드
        //ListView는 아이템을 한번에 빌드함
        var webtoon = snapshot.data![index];
        return Webtoon(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
