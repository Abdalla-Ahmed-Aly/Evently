import 'package:evently/provider/events_provider.dart';
import 'package:evently/tabs/home/event_item.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EventsProvider events_provider = Provider.of(context);
    if (events_provider.events.isEmpty) {
      events_provider.getEvents();
    }
    return Column(
      children: [
        HomeHeader(),
        SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (_, index) => EventItem(
              event: events_provider.events[index],
            ),
            itemCount: events_provider.events.length,
            separatorBuilder: (_, __) => SizedBox(
              height: 16,
            ),
          ),
        )
      ],
    );
  }
}
