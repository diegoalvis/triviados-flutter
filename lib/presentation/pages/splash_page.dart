import 'package:flutter/material.dart';
import 'package:triviados/presentation/pages/gameboard_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setupNavigationAnimation(context);
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xffff3a5a), Color(0xfffe494d)])),
            child: Center()));
  }

  void setupNavigationAnimation(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GameBoardPage()));
    });
  }
}