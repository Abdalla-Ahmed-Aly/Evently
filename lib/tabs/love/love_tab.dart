import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:flutter/material.dart';

class LoveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            DefaultTextFormFiled(
              hintText: 'Search for event',
              onChanged: (query) {},
              prefixIcons: 'search',
            ),
            SizedBox(height: 16),
            Expanded(
                child: ListView.separated(
              itemBuilder: (_, index) => Container(),
              itemCount: 10,
              separatorBuilder: (_, __) => SizedBox(
                height: 16,
              ),
            ))
          ],
        ),
      ),
    );
    ;
  }
}
