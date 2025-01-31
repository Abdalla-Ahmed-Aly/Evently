import 'package:evently/app_them.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/provider/events_provider.dart';
import 'package:evently/provider/setting_provider_them.dart';
import 'package:evently/provider/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventsTab extends StatelessWidget {
  static const String routeName = '/events';

  @override
  Widget build(BuildContext context) {
    bool isdark = Provider.of<SettingProviderThem>(context, listen: false).dark;

    Size screenSize = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Event event = ModalRoute.of(context)!.settings.arguments as Event;
    UserProvider user = Provider.of<UserProvider>(context, listen: false);
    EventsProvider eventsProvider =
        Provider.of<EventsProvider>(context, listen: false);
    Event? eventByID =
        eventsProvider.allevent.firstWhere((element) => element.id == event.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Details',
        ),
        actions: [
          Visibility(
            visible: eventByID.UserId == user.currenUser!.id,
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: isdark ? AppThem.primary : null,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/editEvent', arguments: event);
              },
            ),
          ),
          Visibility(
            visible: eventByID.UserId == user.currenUser!.id,
            child: IconButton(
              icon: Icon(
                Icons.delete_rounded,
                color: AppThem.red,
              ),
              onPressed: () {
                FirebaseService.deleteEventById(event.id).then((_) async {
                  await Provider.of<EventsProvider>(context, listen: false)
                      .getEvents();
                  Navigator.pop(context);
                  print('deleted');
                }).catchError((_) {
                  print('error');
                });
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/${event.category.imageName}.png',
                width: double.infinity,
                height: screenSize.height * 0.25,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                event.titel,
                style: textTheme.titleLarge!
                    .copyWith(color: AppThem.primary, fontSize: 24),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8),
              height: screenSize.height * 0.09,
              decoration: BoxDecoration(
                color: isdark ? AppThem.backgroundDark : AppThem.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppThem.primary,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppThem.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/Calendar_Days.svg',
                      width: 24,
                      height: 24,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('d MMMM yyyy').format(event.datetime),
                        style: textTheme.bodyLarge!.copyWith(
                          color: AppThem.primary,
                        ),
                      ),
                      Text(
                        DateFormat('hh:mma').format(event.datetime),
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: textTheme.bodyLarge,
                ),
                Text(event.description, style: textTheme.bodyLarge),
              ],
            )
          ],
        ),
      ),
    );
  }
}
