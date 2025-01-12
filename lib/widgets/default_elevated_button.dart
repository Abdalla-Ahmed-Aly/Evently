import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  DefaultElevatedButton({
    required this.Lable,
    required this.onPressed,
  });
  String Lable;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.sizeOf(context).width, 56)),
      onPressed: onPressed,
      child: Text(
        Lable,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
