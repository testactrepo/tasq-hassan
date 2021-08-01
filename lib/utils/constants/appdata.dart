import 'package:tasq/core/enum/usertype.dart';
import 'package:flutter/material.dart';

class AppData {
  static var globalScaffoldKey = GlobalKey<ScaffoldState>();

  static UserType userType = UserType.USER;

  static String orgProfileUrl =
      'https://upload.wikimedia.org/wikipedia/en/thumb/d/d3/Starbucks_Corporation_Logo_2011.svg/1200px-Starbucks_Corporation_Logo_2011.svg.png';

  static String userProfileUrl =
      'https://img.icons8.com/cotton/2x/gender-neutral-user--v2.png';

  static List<String> activityCategories = [
    "Web Development",
    "Graphic Design",
    "Writing",
    "App Development",
    "Photo Editing",
    "Video Editing",
    "Photography",
    "3D Modelling",
    "Others"
  ];
  static List<String> activityDueCount = [
    "1",
    "3",
    "7",
    "15",
    "30",
  ];
  static List<String> activityAssignTo = [
    "from team",
    "this organization",
    "every one",
  ];
}
