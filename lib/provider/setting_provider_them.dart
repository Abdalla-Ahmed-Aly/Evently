import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProviderThem with ChangeNotifier {
  ThemeMode themMode = ThemeMode.dark;
  bool get isDark => themMode == ThemeMode.dark;
  String languageCode = 'en';
  Future<void> changeThem(ThemeMode them) async {
    themMode = them;
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool('isDark', isDark);
    print("Theme changed to: $themMode");
    notifyListeners();
  }

  Future<void> loadTheme() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    bool isDarkMode = sharedPref.getBool('isDark') ?? true;
    themMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    print("Loaded theme: $isDarkMode");
    notifyListeners();
  }

  Future<void> changeLanguage(String Language) async {
    languageCode = Language;
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('Language', languageCode);
    print("Language to: $languageCode");
    notifyListeners();
  }

  Future<void> loadLanguage() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String Language = sharedPref.getString('Language') ?? 'en';
    languageCode = Language;
    print("Loaded Language: $Language");
    notifyListeners();
  }
}
