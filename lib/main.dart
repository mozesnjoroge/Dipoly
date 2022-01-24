import 'package:dipoly/animation.dart';
import 'package:dipoly/dice.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DipolyApp());
}

class DipolyApp extends StatelessWidget {
  const DipolyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const AnimationPage(),
    );
  }
}
