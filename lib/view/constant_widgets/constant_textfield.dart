import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/constants/colors.dart';

class ConstantTextField extends StatelessWidget {
  const ConstantTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.suffixIcon,
    this.obscureText,
    this.onTapSuffixIcon
  });

  final TextEditingController controller;
  final String hintText;
  final IconData suffixIcon;
  final bool? obscureText;
  final VoidCallback? onTapSuffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: InkWell(
            onTap: onTapSuffixIcon,
              child: Icon(suffixIcon)),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kBlack)
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlack)
          )
      ),
    );
  }
}