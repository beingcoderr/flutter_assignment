import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextScreen;

  const SplashScreen({Key key, this.nextScreen}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _blueVisible = false,
      _orangeVisible = false,
      _purpleVisible = false,
      _redVisible = false;

  final int _delay = 500;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: _delay * 2)).then((value) {
      setState(() {
        _blueVisible = true;
      });
    });
    Future.delayed(Duration(milliseconds: _delay * 3)).then((value) {
      setState(() {
        _orangeVisible = true;
      });
    });
    Future.delayed(Duration(milliseconds: _delay * 4)).then((value) {
      setState(() {
        _purpleVisible = true;
      });
    });
    Future.delayed(Duration(milliseconds: _delay * 5)).then((value) {
      setState(() {
        _redVisible = true;
      });
    });
    Future.delayed(Duration(milliseconds: _delay * 7)).then((value) {
      Get.offAll(widget.nextScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: _blueVisible ? 250 : 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 70.0, top: 70),
                child: Image.asset(
                  'assets/blue.png',
                  width: 150,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: _orangeVisible ? 200 : 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 50.0, bottom: 25),
                child: Image.asset(
                  'assets/orange.png',
                  width: 100,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: _purpleVisible ? 250 : 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 70.0, top: 70),
                child: Image.asset(
                  'assets/purple.png',
                  width: 150,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: _redVisible ? 250 : 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0, bottom: 50),
                child: Image.asset(
                  'assets/red.png',
                  width: 150,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/white-logo.png',
              width: 150,
            ),
          ),
        ],
      ),
    );
  }
}
