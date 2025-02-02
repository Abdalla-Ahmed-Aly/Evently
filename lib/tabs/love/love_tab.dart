import 'package:evently/event_tab/events_details.dart';
import 'package:evently/models/event.dart';
import 'package:evently/provider/events_provider.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/tabs/home/event_item.dart';
import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoveTab extends StatefulWidget {
  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  late EventsProvider eventsProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      List<String> eventFavoriteIds =
          Provider.of<UserProvider>(context, listen: false)
              .currenUser!
              .eventFavoriteIds;
      eventsProvider.filtereventsByFavorite(eventFavoriteIds);
    });
  }

  @override
  Widget build(BuildContext context) {
        AppLocalizations app_localizations = AppLocalizations.of(context)!;

    eventsProvider = Provider.of<EventsProvider>(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            DefaultTextFormFiled(
              hintText: app_localizations.search,
              onChanged: (query) {
                eventsProvider.searchEventTitle(query);
                setState(() {});
              },
              prefixIcons: 'search',
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) {
                  List<Event> filteredEvents = eventsProvider.favoriteevents
                      .where((event) => eventsProvider.filterevent
                          .contains(event)) 
                      .toList();
                  return InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                      EventsTab.routeName,
                      arguments: filteredEvents[index],
                    ),
                    child: EventItem(event: filteredEvents[index]),
                  );
                },
                itemCount: eventsProvider.favoriteevents
                    .where((event) => eventsProvider.filterevent
                        .contains(event)) 
                    .toList()
                    .length,
                separatorBuilder: (_, __) => SizedBox(
                  height: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
