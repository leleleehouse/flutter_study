import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  int totalPomo = 0;

  late Timer
      timer; // 이 timer는 지금 당장 초기화할 수 없으므로 late 선언 근데 property를 선언하기 전에 초기화하겠다고 약속하는거임

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomo = totalPomo + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      // 1초마다 homescreenstate에서 setstate를 실행
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
    //그럼 배열처럼 생긴 문자열이 나옴
  }

  void onStartPressed() {
    // 함수를 1초마다 실행
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
      //onTick() 은 함수를 지금 실행한다는 의미이므로 지금 ()는 쓰지말아야함
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel(); // timer를 멈추는 역할
    setState(() {
      isRunning = false;
    });
  }

  void onReset() {
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = twentyFiveMinutes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  fontSize: 89,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(isRunning
                          ? Icons.pause_circle_filled_outlined
                          : Icons.play_circle_fill_outlined),
                      iconSize: 100,
                      color: Theme.of(context).cardColor,
                      onPressed: isRunning ? onPausePressed : onStartPressed),
                  IconButton(
                      icon: Icon(Icons.refresh),
                      iconSize: 100,
                      color: Theme.of(context).cardColor,
                      onPressed: onReset),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '뽀모도로',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.color,
                          ),
                        ),
                        Text(
                          '$totalPomo',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
