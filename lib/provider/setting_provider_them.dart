import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProviderThem with ChangeNotifier {
  bool isDark = true;
  bool get dark => isDark;

  Future<void> changeThem(bool dark) async {
    isDark = dark;
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool('isDark', isDark);
    print("Theme changed to: $isDark");  
    notifyListeners();
  }

  Future<void> loadTheme() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    isDark = sharedPref.getBool('isDark') ?? true;
    print("Loaded theme: $isDark"); 
    notifyListeners();
  }
}
