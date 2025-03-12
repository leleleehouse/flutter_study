import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen_toonflix.dart';
import 'package:toonflix/services/api_service.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreenToonflix(),
    );
  }
}
