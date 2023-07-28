import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/screens/home.dart';
import 'package:notes/screens/optional.dart';
import 'package:notes/services/StorageService.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? appStatus;
  @override
  void initState() {
    super.initState();
    timer();
  }

  timer() {
    var duration = const Duration(seconds: 2);
    return Timer(duration, checkApplicationStatus);
  }

  checkApplicationStatus() async {
    appStatus = await StorageService().getApplicationStatus();
    if (appStatus == true) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const CreatePage(),
          ),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const OptionalScreen(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image(
              width: 150,
              height: 150,
              image: AssetImage('assets/images/heroImage.png'),
            ),
          ),
          Text(
            "Notes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
