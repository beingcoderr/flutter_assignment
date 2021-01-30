import 'package:flutter/material.dart';
import 'package:flutter_assignment/home.dart';
import 'package:flutter_assignment/splashscreen.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        nextScreen: Home(),
      ),
    );
  }
}
