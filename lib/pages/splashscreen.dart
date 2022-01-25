import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../const.dart';
import 'Homepage.dart';


class Splash extends StatelessWidget {
  const Splash({ Key? key }) : super(key: key);
      static const String route = '/';


  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen(
          duration: 1500,
          splashTransition: SplashTransition.scaleTransition,
          splash: SvgPicture.asset(
              "assets/commun_toutes_pages/logo_général/logo_lettre_K.svg"),
          nextScreen: const Homepage(),
          backgroundColor: rose,
        
    );
  }
}