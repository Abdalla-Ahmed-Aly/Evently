import 'package:evently/event_tab/events_details.dart';
import 'package:evently/provider/events_provider.dart';
import 'package:evently/tabs/home/event_item.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);

    if (eventsProvider.filterevent.isEmpty) {
      eventsProvider.getEvents();
    }

    return Column(
      children: [
        HomeHeader(),
        SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (_, index) => InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  EventsTab.routeName,
                  arguments: eventsProvider.filterevent[index],
                );
              },
              child: EventItem(
                event: eventsProvider.filterevent[index],
              ),
            ),
            itemCount: eventsProvider.filterevent.length,
            separatorBuilder: (_, __) => SizedBox(
              height: 16,
            ),
          ),
        ),
      ],
    );
  }
}
