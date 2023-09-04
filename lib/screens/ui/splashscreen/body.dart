import 'dart:async';

import 'package:codecarrots_unotraders/screens/Location/location_permission_screen.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:codecarrots_unotraders/main.dart';
import 'package:codecarrots_unotraders/screens/auth/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (sp!.getString('token') != null) {
      Timer(
        const Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const PermissionScreen())),
      );
    } else {
      Timer(
        const Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: AppColor.gradientColor,
        ),
        child: Center(
          child: CircleAvatar(
            backgroundColor: AppColor.whiteColor,
            radius: MediaQuery.of(context).size.width * 0.3,
            child: Image.asset(
              PngImages.logo,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
        ),
      ),
    );
  }
}
