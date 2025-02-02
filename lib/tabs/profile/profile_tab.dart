import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/app_them.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/language.dart';
import 'package:evently/provider/setting_provider_them.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/tabs/profile/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileTab extends StatelessWidget {
  List<Language> Languages = [
    Language(code: 'en', name: 'English'),
    Language(code: 'ar', name: 'العربية'),
  ];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    SettingProviderThem settingProviderThem =
        Provider.of<SettingProviderThem>(context, listen: false);
    AppLocalizations app_localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        ProfileHeader(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      app_localizations.dark,
                      style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700, color: AppThem.primary),
                    ),
                    AnimatedToggleSwitch<bool>.size(
                      values: [true, false],
                      current: settingProviderThem.isDark,
                      onChanged: (isdark) {
                        settingProviderThem.changeThem(
                            isdark ? ThemeMode.dark : ThemeMode.light);
                      },
                      iconBuilder: (value) {
                        return Icon(
                          value
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined,
                          color: AppThem.primary,
                        );
                      },
                    )
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      app_localizations.language,
                      style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700, color: AppThem.primary),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppThem.primary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(16),
                        value: settingProviderThem.languageCode,
                        items: Languages.map((Language) => DropdownMenuItem(
                              child: Text(
                                Language.name,
                                style: textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppThem.primary),
                              ),
                              value: Language.code,
                            )).toList(),
                        onChanged: (LanguageCode) {
                          if (LanguageCode != null) {
                            settingProviderThem.changeLanguage(LanguageCode);
                          }
                        },
                        underline: SizedBox(),
                        iconEnabledColor: AppThem.primary,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    FirebaseService.Logout().then((_) {
                      Provider.of<UserProvider>(context, listen: false)
                          .updateuser(null);
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    }).catchError((error) {
                      print(error);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 28),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppThem.red,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          color: AppThem.white,
                        ),
                        Text(
                          app_localizations.logout,
                          style: textTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
