import 'package:flutter/material.dart';
import 'package:world_time_app/screens/choose_location.dart';
import 'package:world_time_app/screens/homepage.dart';
import 'package:world_time_app/screens/loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => HomePage(),
        '/location': (context) => ChooseLocation(),
      },
    );
  }
}
