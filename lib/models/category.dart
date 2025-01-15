import 'package:flutter/material.dart';

class Category {
  String id;
  String name;
  IconData icon;
  String imageName;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.imageName,
  });

  static List<Category> categories = [
    Category(
      id: '1',
      name: 'Sports',
      icon: Icons.sports_baseball,
      imageName: 'sport',
    ),
    Category(
      id: '2',
      name: 'Birthday',
      icon: Icons.cake_outlined,
      imageName: 'birthday',
    ),
    Category(
      id: '3',
      name: 'Meetings',
      icon: Icons.people,
      imageName: 'meeting',
    ),
    Category(
      id: '4',
      name: 'Gaming',
      icon: Icons.videogame_asset,
      imageName: 'gaming',
    ),
    Category(
      id: '5',
      name: 'Eating',
      icon: Icons.restaurant,
      imageName: 'eating',
    ),
    Category(
      id: '6',
      name: 'Holiday',
      icon: Icons.beach_access,
      imageName: 'holiday',
    ),
    Category(
      id: '7',
      name: 'Exhibition',
      icon: Icons.art_track,
      imageName: 'exhibition',
    ),
    Category(
      id: '8',
      name: 'Workshop',
      icon: Icons.build,
      imageName: 'workshop',
    ),
    Category(
      id: '9',
      name: 'BookClub',
      icon: Icons.menu_book,
      imageName: 'bookclub',
    ),
  ];
}
