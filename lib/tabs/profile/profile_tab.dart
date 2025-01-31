import 'package:evently/app_them.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/provider/setting_provider_them.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/tabs/profile/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    SettingProviderThem isdark = Provider.of<SettingProviderThem>(context,listen: false);

    return Column(
      children: [
        ProfileHeader(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dark Mode',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppThem.primary
                      ),
                    ),
                    Switch(
                        value: isdark.dark,
                        onChanged: (them) {
                          isdark
                              .changeThem(them);
                        })
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
                          'Logout',
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
