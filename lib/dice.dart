import 'package:flutter/material.dart';
import 'dart:math' as math;

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  //default die values
  int leftDiceValue = 1;
  int rightDiceValue = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('Dipoly'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  leftDiceValue = math.Random().nextInt(6) + 1;
                  rightDiceValue = math.Random().nextInt(6) + 1;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(
                      image: AssetImage('asset/dice$leftDiceValue.png'),
                      width: 150,
                      height: 150),
                  Image(
                    image: AssetImage('asset/dice$rightDiceValue.png'),
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

//TODO: Set the App Theme
