import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:async';

import '../utils/themes.dart';

// ignore: use_key_in_widget_constructors
class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  int x = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemes.grad2,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/splashScreen.png")),
          30.heightBox,
          Container(
            alignment: Alignment.center,
            child: const Text(
              "Dayalbagh Biometric",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                fontSize: 15,
              ),
            ),
          ),
          const Text("Identity Verification",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                fontSize: 15,
              )),

          const SizedBox(
            height: 40,
          ),
          // Lottie.asset("assets/images/loading.json")
        ],
      ),
    );
  }

  startTime() async {
    Future.delayed(
        Duration(seconds: 1),
        () async => {
              Navigator.pushNamed(context, "/login"),
            });

    //Navigator.pushNamed(context, page);
  }
}
