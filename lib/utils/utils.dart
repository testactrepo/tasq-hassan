import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/naviation_services.dart';
import 'package:flutter/material.dart';

class Utils {
  static showSnackbar({@required scaffoldKey, @required message}) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: new Text(message)));
  }

  static navigateTo(routeName, {arguments}) {
    locator<NavigationService>().navigateTo(routeName, arguments: arguments);
  }

  static navigateAndReplacePageRoute({@required route, arguments}) {
    locator<NavigationService>()
        .navigateAndReplaceTo(route, arguments: arguments);
  }

  static navigateToPage(context, {@required page}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static navigateAndReplacePage(context, {@required page}) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static getCombineUid(String uid1, String uid2) {
    if (uid1.compareTo(uid2) == -1) return uid1 + uid2;
    return uid2 + uid1;
  }

  static int pointsAlgorithm(String categoryname) {
    switch (categoryname) {
      case "Web Development":
        return 60;
      case "Graphic Design":
        return 20;
      case "Writing":
        return 40;
      case "App Development":
        return 60;
      case "Photo Editing":
        return 15;
      case "Video Editing":
        return 35;
      case "Photography":
        return 20;
      case "3D Modelling":
        return 60;
      default:
        return 60;
    }
  }

  static bool isUnreadMsg(chatroom, currentuseruid) {
    if (chatroom.unreadmessagescount != null &&
        chatroom.recentMsg.sendBy != currentuseruid &&
        chatroom.unreadmessagescount != 0)
      return true;
    else
      return false;
  }
}
