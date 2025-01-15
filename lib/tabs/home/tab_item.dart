import 'package:evently/app_them.dart';
import 'package:evently/models/category.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  TabItem({required this.category, required this.isSelected});
  Category category;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: isSelected ? AppThem.white : Colors.transparent,
          border: (Border.all(
            width: 1,
            color: AppThem.white,
          )),
          borderRadius: BorderRadius.circular(46)),
      child: Row(
        children: [
          Icon(
            category.icon,
            color: isSelected ? AppThem.primary : Colors.white,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            category.name,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? AppThem.primary : Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
