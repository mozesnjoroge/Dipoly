import 'package:flutter/material.dart';

class RotatingTransition extends StatelessWidget {
  final Widget rotatingWidget;
  final Animation<double>? rotationAngle;

  const RotatingTransition(
      {required this.rotatingWidget, required this.rotationAngle});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: rotationAngle!,
        child: rotatingWidget,
        builder: (context, rotatingWidget) {
          return Transform.rotate(
              angle: rotationAngle!.value, child: rotatingWidget);
        });
  }
}