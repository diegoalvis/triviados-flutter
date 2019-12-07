import 'package:flutter/material.dart';
import 'package:triviados/presentation/pages/gameboard_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Triviados',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameBoardPage(title: 'Flutter Demo Clean Arquitecture'),
    );
  }
}

