import 'package:evently/app_them.dart';
import 'package:evently/models/category.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  TabItem({
    required this.lable,
    required this.icon,
    required this.isSelected,
    required this.selectBackgroundColor,
    required this.selectForegroundColor,
    required this.UnselectForegroundColor,
  });
  String lable;
  IconData icon;
  bool isSelected;
  Color selectBackgroundColor;
  Color selectForegroundColor;
  Color UnselectForegroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: isSelected ? selectBackgroundColor : Colors.transparent,
          border: isSelected
              ? null
              : (Border.all(
                  width: 1,
                  color: UnselectForegroundColor,
                )),
          borderRadius: BorderRadius.circular(46)),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? selectForegroundColor : UnselectForegroundColor,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            lable,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected
                      ? selectForegroundColor
                      : UnselectForegroundColor,
                ),
          ),
        ],
      ),
    );
  }
}
