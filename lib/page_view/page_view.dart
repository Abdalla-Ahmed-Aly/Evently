import 'package:evently/app_them.dart';
import 'package:evently/page_view/PageIndicator.dart';
import 'package:evently/page_view/page_view_class.dart';
import 'package:evently/page_view/page_view_details.dart';
import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  static const routeName = '/MyPageView';

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> with TickerProviderStateMixin {
  late PageController _pageViewController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Container(
                width: double.infinity,
                height: screenHeight * 0.1,
                child: Image.asset(
                  'assets/images/headerphoto.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: PageView(
                controller: _pageViewController,
                onPageChanged: _handlePageViewChanged,
                children: <Widget>[
                  PageViewDetails(PageViewClass(
                    image: 'introscreen1',
                    text1: 'Find Events That Inspire You',
                    text2:
                        "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
                  )),
                  PageViewDetails(PageViewClass(
                    image: 'introscreen2',
                    text1: 'Effortless Event Planning',
                    text2:
                        'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.',
                  )),
                  PageViewDetails(PageViewClass(
                      image: 'introscreen3',
                      text1: 'Connect with Friends & Share Moments',
                      text2:
                          'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.')),
                 
                 
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: PageIndicator(
                pageController: _pageViewController,
                currentPageIndex: _currentPageIndex,
                onUpdateCurrentPageIndex: _updateCurrentPageIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, String imagePath, String text) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.only(top: 79),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: MediaQuery.sizeOf(context).height * 0.39,
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            text,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppThem.primary,
            ),
          ),
        ],
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentPageIndex = index;
    });
  }
}
