import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/text_styles.dart';

class ConstantButton extends StatelessWidget {
  const ConstantButton({
    required this.text,
    required this.buttonColor,
    required this.textColor,
    required this.onTap,
    this.isCompleted = false,
    super.key,
  });

  final Color buttonColor;
  final Color textColor;
  final String text;
  final VoidCallback onTap;
  final bool? isCompleted;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.065,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(15)),
        child: Center(child: isCompleted == false ? Text(text, style: const TextStyle(fontSize: 18, color: Colors.white))
      : const SpinKitCircle(color: Colors.black,)),
      ),
    );
  }
}