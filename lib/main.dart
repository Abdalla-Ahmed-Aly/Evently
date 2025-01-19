import 'package:evently/app_them.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/create_event_screen.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/page_view/page_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  bool introscreen = sharedPref.getBool('introscreen') ?? false;
  runApp(EventlyApp(introscreen: introscreen));
  
}

class EventlyApp extends StatelessWidget {
  final bool introscreen;
  EventlyApp({required this.introscreen});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        MyPageView.routeName: (_) => MyPageView(),
        CreateEventScreen.routeName: (_) => CreateEventScreen(),
      },
      initialRoute: introscreen ? HomeScreen.routeName : MyPageView.routeName,
      theme: AppThem.LightThem,
      darkTheme: AppThem.darkThem,
      themeMode: ThemeMode.light,
    );
  }
}
