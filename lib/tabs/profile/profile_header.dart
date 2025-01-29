import 'package:evently/app_them.dart';
import 'package:evently/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
   UserModel user=   Provider.of<UserProvider>(context,listen: false).currenUser!;
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
                  user.name,
                  style: textTheme.displayMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  user.email,
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
