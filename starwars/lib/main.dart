import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:starwars/animatedSplash.dart';
import 'package:starwars/carousel.dart';
import 'package:starwars/characterList.dart';
import 'package:starwars/loginPage.dart';
import 'package:starwars/registerPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Star Wars',
      home: SplashAnimation(),
    );
  }
}
