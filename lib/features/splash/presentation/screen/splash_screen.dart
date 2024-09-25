import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_management/features/auth/presentation/screen/login_screen.dart';
import 'package:tasks_management/features/tasks/presentation/screen/main_screen.dart';
import 'package:tasks_management/theme_manager/color_manager.dart';
import 'package:tasks_management/theme_manager/font_family_manager.dart';
import 'package:tasks_management/theme_manager/space_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? _token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();

    Timer(const Duration(seconds: 5), () {
      if (_token == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      }
    });
  }

  Future<void> getToken() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      _token = pref.getString('access_token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/logo/logo_splash.png',
            width: 150,
            height: 150,
          )),
          34.0.spaceY,
          SpinKitRing(
            color: ColorManager.primary,
            lineWidth: 4.5,
            size: 40.0,
          ),
          10.0.spaceY,
          Text(
            "Loading...",
            style: blackRegularTextStyle.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}
