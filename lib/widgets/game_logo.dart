import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameLogo extends StatelessWidget {
  final Animation<double>? logoFadeAnimation;

  GameLogo({this.logoFadeAnimation});

  static String logoAssetName = 'asset/game_logo/rich_uncle.svg';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: FadeTransition(
        opacity: logoFadeAnimation!,
        child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child:
                // FlutterLogo(
                //   size: 150.0,
                // )
                SvgPicture.asset(
              logoAssetName,
              color: Colors.white,
              height: 100.0,
            )),
      ),
    );
  }
}
