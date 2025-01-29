import 'dart:ffi';

import 'package:evently/app_them.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  PageIndicator({
    required this.pageController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
  });

  final int currentPageIndex;
  final PageController pageController;
  final void Function(int) onUpdateCurrentPageIndex;

  @override
  Widget build(BuildContext context) {
    String text2 = 'next';
    bool introsreen = false;

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 0) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
              pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            icon: Visibility(
              visible: currentPageIndex > 0,
              child: SvgPicture.asset('assets/icons/back.svg')
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: WormEffect(
              dotHeight: 12.0,
              dotWidth: 12.0,
              type: WormType.normal,
              activeDotColor: AppThem.primary,
              dotColor: Color(0xff1C1C1C),
            ),
          ),
        IconButton(
  splashRadius: 16.0,
  padding: EdgeInsets.zero,
  onPressed: () async {
    if (currentPageIndex == 2) {
      Navigator.popAndPushNamed(context, LoginScreen.routeName);
      await navigateAndSave(); 
    
    } else {
      onUpdateCurrentPageIndex(currentPageIndex + 1);
      pageController.nextPage(
        duration: Duration(milliseconds: 0),
        curve: Curves.easeIn,
      );
    }
  },
  icon: SvgPicture.asset(
    currentPageIndex == 3 ? 'Finish' : 'assets/icons/$text2.svg', 

    
  ),
          ),
        ],
      ),
    );
  }
}

Future<void> navigateAndSave() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sharedPref.setBool('introscreen', true);
}
