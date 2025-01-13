import 'package:evently/app_them.dart';
import 'package:evently/nav_bar_icon.dart';
import 'package:evently/tabs/home/home_tab.dart';
import 'package:evently/tabs/love/love_tab.dart';
import 'package:evently/tabs/map/map_tab.dart';
import 'package:evently/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), LoveTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: AppThem.primary,
        padding: EdgeInsets.zero,
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: 'home_select'),
              label: 'Home',
              activeIcon: NavBarIcon(imageName: 'home_un_select'),
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: 'map_select'),
              label: 'Map',
              activeIcon: NavBarIcon(imageName: 'Map_un_select'),
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: 'love_select'),
              label: 'Love',
              activeIcon: NavBarIcon(imageName: 'love_un_select'),
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: 'user_select'),
              label: 'User',
              activeIcon: NavBarIcon(imageName: 'user_un_select'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
