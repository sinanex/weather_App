import 'dart:async';
import 'dart:math';

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
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), themeCheck());
  }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold();
  }
  
   themeCheck()async {
SharedPreferences _pref = await SharedPreferences.getInstance();
     bool? themedata =  await  _pref.getBool('theme');
     if(themedata == true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
     }

   }
}