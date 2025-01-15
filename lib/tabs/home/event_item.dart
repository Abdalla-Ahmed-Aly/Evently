import 'package:evently/app_them.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/sport.png',
            width: double.infinity,
            height: screenSize.height*0.24,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppThem.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Text(
                '21',
                style: textTheme.titleLarge?.copyWith(
                    color: AppThem.primary, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Nov',
                style: textTheme.titleLarge?.copyWith(
                    color: AppThem.primary, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Positioned(
          width: screenSize.width-32,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppThem.white, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Meeting for Updating The Development Method ',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_outline_rounded,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
