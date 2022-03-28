import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:verification_module/pages/homePage.dart';
import 'package:verification_module/pages/login.dart';
import 'package:verification_module/pages/splashScreen.dart';
import 'package:verification_module/pages/verify.dart';

import 'package:verification_module/utils/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'DB Biometric Enrollment',
      theme: MyThemes.lightTheme(context),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => Splash(),
        "/home": (context) => HomePage(),
        "/login": (context) => LoginPage(),
        "/verify": (context) => QRViewExample(),
      },
    );
  }
}
