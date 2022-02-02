import 'package:dipoly/widgets/rotatingTransition.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;

import 'widgets/game_logo.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  int? _leftDiceValue;
  int? _rightDiceValue;
  FToast fToast = FToast();

  late final AnimationController _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 2),
      vsync: this);

  late final Animation<double>? _animation = Tween<double>(
    begin: 0,
    end: 2 * math.pi,
    //nesting curved animation over the initial animation
  ).animate(
    CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceIn,
        reverseCurve: Curves.bounceOut),
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.forward();
      } else if (status == AnimationStatus.forward) {}
    });

  /*TODO: set bouncing in function, different duration for individual bouncing effect*/
  late final AnimationController _bounceAnimController =
      AnimationController(duration: const Duration(seconds: 2), vsync: this);

  late final Animation<double> _fadeAnimation = CurvedAnimation(
    parent: _bounceAnimController,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    _bounceAnimController.forward();
    _animationController.forward();
    _diceValueSetter();
    fToast.init(context);
  }

  void _diceValueSetter() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () => setState(
        () {
          _leftDiceValue = math.Random().nextInt(6) + 1;
          _rightDiceValue = math.Random().nextInt(6) + 1;
        },
      ),
    );
    _showUpdateToast();
  }

  void _diceValueResetter() {
    setState(() {
      _leftDiceValue = 0;
      _rightDiceValue = 0;
    });
  }

  void _showUpdateToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.black),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(width: 5.0),
          Text(
            'Tap any dice to roll !!!',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 2),
        gravity: ToastGravity.BOTTOM);
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
            logoFadeAnimation: _fadeAnimation,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                _diceValueResetter();
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
                            'asset/die_images/dice${_leftDiceValue ?? 0}.png'),
                        width: 150,
                        height: 150),
                  ),
                  RotatingTransition(
                    rotationAngle: _animation!,
                    rotatingWidget: Image(
                      image: AssetImage(
                          'asset/die_images/dice${_rightDiceValue ?? 0}.png'),
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
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _bounceAnimController.dispose();

    super.dispose();
  }
}
