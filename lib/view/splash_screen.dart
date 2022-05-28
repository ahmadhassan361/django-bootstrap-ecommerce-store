
import 'package:flutter/material.dart';
import 'package:quantum_genius/view/login.dart';
import 'package:quantum_genius/view/main_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../utils/shared_pref_funcs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SplashScreenView(
          navigateRoute: const MainScreen(),
          duration: 50,
          imageSize: 110,

          imageSrc: "images/logo.png",
          textType: TextType.ColorizeAnimationText,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
          colors: const [
            Colors.purple,
            Colors.blue,
            Colors.yellow,
            Colors.red,
          ],
          backgroundColor: Colors.white,
        )
    );
  }


}
