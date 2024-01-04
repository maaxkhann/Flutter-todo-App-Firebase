import 'package:flutter/material.dart';

class ConstantTextField extends StatelessWidget {
  const ConstantTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.suffixIcon,
      required this.prefixIcon,
      this.obscureText,
      this.onTapSuffixIcon});

  final TextEditingController controller;
  final String hintText;
  final IconData? suffixIcon;
  final IconData prefixIcon;
  final bool? obscureText;
  final VoidCallback? onTapSuffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: InkWell(onTap: onTapSuffixIcon, child: Icon(suffixIcon)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal))),
    );
  }
}
