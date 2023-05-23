import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemeModel extends ChangeNotifier {
  MyThemeModel({required this.sharedPreferences});
  final String key = "theme";
  final SharedPreferences sharedPreferences;
  bool _isLightTheme = true;

  void changeTheme() {
    _isLightTheme = sharedPreferences.getBool('theme') ?? false;
    _isLightTheme = !_isLightTheme;
    sharedPreferences.setBool('theme', _isLightTheme);
    notifyListeners();
  }

  bool? get isAnimated {
    return sharedPreferences.getBool('theme') != null
        ? sharedPreferences.getBool('theme')
        : _isLightTheme;
  }
}
