import 'package:evently/app_them.dart';
import 'package:evently/models/event.dart';
import 'package:evently/provider/events_provider.dart';
import 'package:evently/provider/setting_provider_them.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  EventItem({required this.event});
  Event event;

  @override
  @override
  Widget build(BuildContext context) {
    bool isdark = Provider.of<SettingProviderThem>(context, listen: false).isDark;
    UserProvider user = Provider.of<UserProvider>(context);
    bool isFavorite = user.checkWithFavorite(event.id);
    Size screenSize = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/${event.category.imageName}.png',
            width: double.infinity,
            height: screenSize.height * 0.24,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: isdark ? AppThem.backgroundDark : AppThem.white,
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Text(
                '${event.datetime.day}',
                style: textTheme.titleLarge?.copyWith(
                    color: AppThem.primary, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                DateFormat('MMM').format(event.datetime),
                style: textTheme.titleLarge?.copyWith(
                    color: AppThem.primary, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Positioned(
          width: screenSize.width - 32,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: isdark ? AppThem.backgroundDark : AppThem.white,
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    event.titel,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (isFavorite) {
                      user.removeEventTofavorite(event.id);
                      Provider.of<EventsProvider>(context, listen: false)
                          .filtereventsByFavorite(
                              user.currenUser!.eventFavoriteIds);
                    } else {
                      user.addEventTofavorite(event.id);
                    }
                  },
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    color: AppThem.primary,
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
