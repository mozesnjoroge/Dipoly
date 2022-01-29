import 'package:flutter/material.dart';

class GameLogo extends StatelessWidget {
  final Animation<AlignmentGeometry>? alignmentAnimation;

  const GameLogo({this.alignmentAnimation});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: AlignTransition(
        alignment: alignmentAnimation!,
        child: const Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: FlutterLogo(
            size: 150.0,
          ),
        ),
      ),
    );
  }
}