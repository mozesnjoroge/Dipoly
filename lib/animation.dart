import 'package:dipoly/widgets/rotatingTransition.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'widgets/game_logo.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  int _leftDiceValue = 1;
  int _rightDiceValue = 2;

  late final AnimationController _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      reverseDuration: const Duration(seconds: 1),
      vsync: this);

  late final Animation<double>? _animation = Tween<double>(
    begin: 0,
    end: 2 * math.pi,
    //nesting curved animation over the initial animation
  ).animate(
    CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceIn,
        reverseCurve: Curves.easeOut),
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.forward();
      } else if (status == AnimationStatus.forward) {}
    });

  /*TODO: set bouncing in function, different duration for individual bouncing effect*/
  late final AnimationController _bounceAnimController =
      AnimationController(duration: const Duration(seconds: 2), vsync: this);

  late final Animation<AlignmentGeometry> _bounceAnimation =
      Tween<AlignmentGeometry>(
    begin: Alignment.centerLeft,
    end: Alignment.center,
  ).animate(
    CurvedAnimation(
      parent: _bounceAnimController,
      curve: Curves.bounceOut,
    ),
  );

  @override
  void initState() {
    super.initState();
    _bounceAnimController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('Dipoly'),
        backgroundColor: Colors.red,
      ),
      // body:GameLogo(alignmentAnimation: _bounceAnimation,)
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 100.0,
          ),
          GameLogo(
            alignmentAnimation: _bounceAnimation,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_animation!.isDismissed) {
                  _animationController.forward();
                } else if (_animation!.status == AnimationStatus.completed) {
                  _animationController.reverse();
                }
                _diceValueSetter();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RotatingTransition(
                    rotationAngle: _animation!,
                    rotatingWidget: Image(
                        image: AssetImage(
                            'asset/die_images/dice$_leftDiceValue.png'),
                        width: 150,
                        height: 150),
                  ),
                  RotatingTransition(
                    rotationAngle: _animation!,
                    rotatingWidget: Image(
                      image: AssetImage(
                          'asset/die_images/dice$_rightDiceValue.png'),
                      width: 150,
                      height: 150,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      // RotatingTransition(
      //     rotatingWidget: const DicePage(), rotationAngle: animation!),
    );
  }

  void _diceValueSetter() {
    setState(() {
      _leftDiceValue = math.Random().nextInt(6) + 1;
      _rightDiceValue = math.Random().nextInt(6) + 1;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    _bounceAnimController.dispose();
    super.dispose();
  }
}

//TODO: init state to have a random roll
