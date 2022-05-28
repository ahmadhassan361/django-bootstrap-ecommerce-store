import 'package:flutter/material.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NexGen Shop',
      theme: ThemeData(

        primarySwatch: Colors.grey,
        primaryColor: HEADING_COLOR,
        secondaryHeaderColor: Colors.red,
        fontFamily: 'Roboto'
      ),
      home: const SplashScreen()
    );
  }
}

