import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/homePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashCheck();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(child: Text("Weather",style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),),),
    );
  }

 Future<void> SplashCheck() async {
   Timer(Duration(seconds: 2),()=> Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage())));
     
  }
}
