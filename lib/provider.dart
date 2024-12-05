import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class themeChangeProvider extends ChangeNotifier {
  Brightness theme = Brightness.light;
  Color imageColor = Colors.black;
  bool Dark = false;

  void changeTheme(bool value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    if (Dark == false) {
      theme = Brightness.dark;
      Dark = true;
      imageColor = Colors.white;
      _pref.setBool('theme', true);
    } else {
      theme = Brightness.light;
      Dark = false;
      imageColor = Colors.black;
      _pref.setBool('theme', false);
    }
    notifyListeners();
  }
}
