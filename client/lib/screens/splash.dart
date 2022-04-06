import 'dart:async' as async;

import 'package:flutter/material.dart';
import 'package:noty_client/screens/start/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late async.Timer _timer;

  _SplashScreenState() {
    _timer = async.Timer(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()) // Use pushReplacement for clear backstack.
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: .6,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple, Colors.purpleAccent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.mirror,
                      stops: [.5, 6]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
