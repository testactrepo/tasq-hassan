import 'package:tasq/utils/constants/mycolors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Gradient gradient;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final double borderRadiusValue;
  final Color borderColor;
  final double borderWidth;
  final double width;
  final double height;
  final bool selected;
  final bool disableBorder;
  final VoidCallback onTap;
  const CustomButton({
    @required this.text,
    @required this.onTap,
    this.color: Colors.transparent,
    this.gradient,
    this.textColor: Colors.white,
    this.fontSize: 14,
    this.fontWeight: FontWeight.normal,
    this.borderRadiusValue: 10,
    this.borderColor: Colors.red,
    this.borderWidth: 2.0,
    this.width,
    this.height,
    this.selected: false,
    this.padding: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
    this.disableBorder: false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: gradient == null
              ? !selected
                  ? color
                  : MyColors.primaryColor
              : null,
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadiusValue),
          border: disableBorder
              ? null
              : Border.all(color: borderColor, width: borderWidth),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: !selected ? textColor : Colors.white,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }
}
