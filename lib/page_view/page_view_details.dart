import 'package:evently/app_them.dart';
import 'package:evently/page_view/page_view_class.dart';
import 'package:flutter/material.dart';

class PageViewDetails extends StatelessWidget {
  final PageViewClass pageViewclass;
  PageViewDetails(this.pageViewclass);
  
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.only(top: 79.0,bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'assets/images/${pageViewclass.image}.png',
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20,),
          Text(
            pageViewclass.text1,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppThem.primary,
            ),
          ),
          SizedBox(
            height: 39,
          ),
          Expanded(
            child: Text(
              pageViewclass.text2,
              style: textTheme.bodyLarge
            ),
          ),
        ],
      ),
    );
  }
}
