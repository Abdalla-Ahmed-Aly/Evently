import 'package:evently/provider/events_provider.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/tabs/home/event_item.dart';
import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    List<String> eventFavoriteIds =
        Provider.of<UserProvider>(context).currenUser!.eventFavoriteIds;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      eventsProvider.filtereventsByFavorite(eventFavoriteIds);
    });

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            DefaultTextFormFiled(
              hintText: 'Search for event',
              onChanged: (query) {},
              prefixIcons: 'search',
            ),
            SizedBox(height: 16),
            Expanded(
                child: ListView.separated(
              itemBuilder: (_, index) =>
                  EventItem(event: eventsProvider.favoriteevents[index]),
              itemCount: eventsProvider.favoriteevents.length,
              separatorBuilder: (_, __) => SizedBox(
                height: 16,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
