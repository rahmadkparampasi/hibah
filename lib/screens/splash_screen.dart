import 'dart:async';

import 'package:SimhegaM/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _width = 200;
  double _height = 200;

  // @override
  void updateState() {
    setState(() {
      _width = 300;
      _height = 300;
    });
  }

  @override
  void initState() {
    super.initState();
    updateState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(
            token: '',
            selectedIndex: 0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _width,
                  height: _height,
                  curve: Curves.bounceIn,
                  child: Image.asset(
                    "assets/images/favicon.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'SI-MHEGA',
                  style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'SISTEM INFORMASI MANAJEMEN HIBAH KEAGAMAAN',
                  style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
