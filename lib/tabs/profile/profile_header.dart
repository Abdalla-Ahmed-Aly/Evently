import 'package:evently/app_them.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppThem.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            64,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Image.asset(
              'assets/images/profile.png',
              height: MediaQuery.sizeOf(context).height * 0.12,
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Abdullah Ahmed',
                  style: textTheme.displayMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'abdalla@gmail.com',
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppThem.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
