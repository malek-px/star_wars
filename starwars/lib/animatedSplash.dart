import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:starwars/loginPage.dart';

class SplashAnimation extends StatelessWidget {
  const SplashAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splash: Image.asset(
            'assets/images/star_wars_logo.png',
            width: 500.0,
            height: 200.0,
          ),
          duration: 4000,
          nextScreen: const Login(),
          
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: const Color.fromARGB(255, 53, 53, 53),
        ));
  }
}
