import 'package:flutter/material.dart';

class MyColors {
  static Color tabBGColor = Color(0xff1E1E1E);
  static Color primaryColor = Color(0xff0022FF);
  static Color secondaryColor = Color(0xffC525F3);
  static Color silver = Color(0xffbcbcbc);
  static Color taskviewBGColor = Color(0xff1000F2);
  static Color taskviewTextColor = Colors.white;
  static Color rewardsVoucherCodeColor = Color(0xffEB114C);
  static Color messagescreenTabBarBGColor = Color(0xffF5F5F5);
  static Color highlightedColor = Colors.black26;

  static LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [MyColors.secondaryColor, MyColors.primaryColor],
  );

  static const LinearGradient blueGradient = LinearGradient(colors: [
    Color(0xff136CF1),
    Color(0xff0D2DA3),
    Color(0xff0B0BD4),
  ]);

  static const LinearGradient greenGradient = LinearGradient(colors: [
    Color(0xff13F1A5),
    Color(0xff05B579),
  ]);

  static const LinearGradient lineGradient = LinearGradient(colors: [
    Color(0xff17CED5),
    Color(0xff8E00EC),
  ]);

  static const LinearGradient adminGradient = LinearGradient(colors: [
    Color(0xffF6C932),
    Color(0xffF9931E),
  ]);

  static const LinearGradient addTaskButtonGradient = LinearGradient(
    colors: [Color(0xff17CED5), Color(0xff8E00EC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
