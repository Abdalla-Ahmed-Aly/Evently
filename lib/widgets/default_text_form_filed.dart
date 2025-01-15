import 'package:evently/app_them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTextFormFiled extends StatefulWidget {
  DefaultTextFormFiled(
      {this.controller,
      required this.hintText,
      this.prefixIcons,
      this.validator,
      this.isPassword = false,
      this.onChanged});
  TextEditingController? controller;
  String hintText;
  String? prefixIcons;
  String? Function(String?)? validator;
  void Function(String)? onChanged;

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
      onChanged: widget.onChanged,
      decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: SvgPicture.asset(
            'assets/icons/${widget.prefixIcons}.svg',
            height: 24,
            width: 24,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(AppThem.grey, BlendMode.srcIn),
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
