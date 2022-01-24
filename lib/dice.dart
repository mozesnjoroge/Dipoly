import 'package:flutter/material.dart';

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'asset/dice1.png',
                    width: 150,
                    height: 150,
                  ),
                  Image.asset(
                    'asset/dice2.png',
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

//TODO: Set the App Theme
