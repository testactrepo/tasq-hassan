import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final text;
  final Gradient gradient;
  final VoidCallback onTap;
  const GradientContainer(
      {@required this.text,
      @required this.onTap,
      this.gradient: MyColors.blueGradient,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 95.0,
        decoration: BoxDecoration(
            gradient: gradient, borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: Strings.primaryFontName,
                fontSize: 25.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
