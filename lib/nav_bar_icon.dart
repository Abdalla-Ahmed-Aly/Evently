import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarIcon extends StatelessWidget {
  NavBarIcon({required this.imageName});
  String imageName;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$imageName.svg',
      width: 24,
      height: 24,
      fit: BoxFit.scaleDown,
    );
  }
}
