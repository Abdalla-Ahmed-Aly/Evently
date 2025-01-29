import 'package:evently/app_them.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/tabs/profile/profile_header.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return Column(
      children: [
        ProfileHeader(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    FirebaseService.Logout().then((_) {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    }).catchError((error){
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
