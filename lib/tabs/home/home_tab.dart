import 'package:evently/app_them.dart';
import 'package:evently/tabs/home/event_item.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(),
        SizedBox(height: 16),
        Expanded(
            child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (_, index) => EventItem(),
          itemCount: 10,
          separatorBuilder: (_, __) => SizedBox(
            height: 16,
          ),
        ))
      ],
    );
  }
}
