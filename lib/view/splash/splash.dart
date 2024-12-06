import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:weather/view/home/homePage.dart';

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
    return const CupertinoPageScaffold(
      child: Center(child: Text("Weather",style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),),),
    );
  }

 // ignore: non_constant_identifier_names
 Future<void> SplashCheck() async {
   Timer( const Duration(seconds: 2),()=> Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => HomePage())));
     
  }
}
