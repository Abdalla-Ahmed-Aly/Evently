import 'package:evently/app_them.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/create_event_screen.dart';
import 'package:evently/event_tab/edit_event.dart';
import 'package:evently/event_tab/events_details.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/page_view/page_view.dart';
import 'package:evently/provider/events_provider.dart';
import 'package:evently/provider/setting_provider_them.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  bool introscreen = sharedPref.getBool('introscreen') ?? false;
  final settingProvider = SettingProviderThem();
  await settingProvider.loadTheme();
  await settingProvider.loadLanguage();

  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EventsProvider()..getEvents(),
        ),
        ChangeNotifierProvider(
          create: (_) => settingProvider,
        ),
      ],
      child: EventlyApp(introscreen: introscreen),
    ),
  );
}

class EventlyApp extends StatelessWidget {
  final bool introscreen;

  EventlyApp({required this.introscreen});

  @override
  build(BuildContext context) {
    SettingProviderThem SettingProvider =
        Provider.of<SettingProviderThem>(context, listen: true);
    print(SettingProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        MyPageView.routeName: (_) => MyPageView(),
        CreateEventScreen.routeName: (_) => CreateEventScreen(),
        EventsTab.routeName: (_) => EventsTab(),
        EditEvent.routeName: (_) => EditEvent(),
      },
      initialRoute: introscreen ? LoginScreen.routeName : MyPageView.routeName,
      theme: AppThem.LightThem,
      darkTheme: AppThem.darkThem,
      themeMode: SettingProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(SettingProvider.languageCode),
    );
  }
}
