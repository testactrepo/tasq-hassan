import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double radius;
  final Color bgColor;
  const CircularButton({
    this.child: const Text(
      't+',
      style: MyTextStyle.heading18BoldWhite,
    ),
    this.gradient: MyColors.addTaskButtonGradient,
    this.bgColor,
    this.radius: 60.0,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
          gradient: bgColor == null ? gradient : null,
          color: bgColor != null ? bgColor : null,
          shape: BoxShape.circle),
      child: Center(child: child),
    );
  }
}
