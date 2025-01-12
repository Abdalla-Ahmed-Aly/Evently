import 'package:evently/app_them.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(EventlyApp());
}
class EventlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (_)=> LoginScreen(),
      },
      initialRoute: LoginScreen.routeName,
      theme: AppThem.LightThem,
      darkTheme: AppThem.darkThem,
      themeMode: ThemeMode.light,
    );
  }
  
}