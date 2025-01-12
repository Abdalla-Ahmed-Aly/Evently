import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTextFormFiled extends StatefulWidget {
  DefaultTextFormFiled({
    required this.controller,
    required this.hintText,
    this.prefixIcons,
    this.validator,
    this.isPassword = false,
  });
  TextEditingController controller;
  String hintText;
  String? prefixIcons;
  String? Function(String?)? validator;
  bool isPassword;

  @override
  State<DefaultTextFormFiled> createState() => _DefaultTextFormFiledState();
}

class _DefaultTextFormFiledState extends State<DefaultTextFormFiled> {
  late bool isObscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: SvgPicture.asset(
            'assets/icons/${widget.prefixIcons}.svg',
            height: 24,
            width: 24,
            fit: BoxFit.scaleDown,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    isObscure = !isObscure;
                    setState(() {});
                  },
                  icon: Icon(isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                )
              : null),
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,


    );
  }
}
