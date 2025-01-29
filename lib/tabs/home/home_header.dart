import 'package:evently/app_them.dart';
import 'package:evently/models/category.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/provider/events_provider.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    TextTheme textTheme = TextTheme.of(context);
   UserModel  user= Provider.of<UserProvider>(context,).currenUser!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 16,
        bottom: 16,
      ),
      decoration: BoxDecoration(
          color: AppThem.primary,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16))),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back ✨',
              style: textTheme.bodyMedium?.copyWith(color: AppThem.white),
            ),
            Text(
              user.name,
              style: textTheme.displayMedium,
            ),
            SizedBox(
              height: 16,
            ),
            DefaultTabController(
              length: Category.categories.length + 1,
              child: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.symmetric(horizontal: 10),
                  onTap: (index) {
                    if (currentIndex == index) return;
                    currentIndex = index;
                    eventsProvider.filterEventsByCategory(
                      index == 0 ? null : Category.categories[index - 1],
                    );
                  },
                  tabs: [
                    TabItem(
                      lable: 'All',
                      icon: Icons.all_inclusive,
                      isSelected: currentIndex == 0,
                      selectBackgroundColor: AppThem.white,
                      selectForegroundColor: AppThem.primary,
                      UnselectForegroundColor: AppThem.white,
                    ),
                    ...Category.categories.map(
                      (category) => TabItem(
                        lable: category.name,
                        icon: category.icon,
                        isSelected: currentIndex ==
                            Category.categories.indexOf(category) + 1,
                        selectBackgroundColor: AppThem.white,
                        selectForegroundColor: AppThem.primary,
                        UnselectForegroundColor: AppThem.white,
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
