import 'package:tasq/utils/constants/mycolors.dart';
import 'package:flutter/material.dart';

class LineGradient extends StatelessWidget {
  final width;
  const LineGradient({this.width: double.infinity, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 3.0,
      decoration: BoxDecoration(gradient: MyColors.lineGradient),
    );
  }
}
