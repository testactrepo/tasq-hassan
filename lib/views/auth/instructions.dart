import 'package:tasq/core/enum/usertype.dart';
import 'package:tasq/utils/constants/appdata.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:tasq/views/widgets/custombutton.dart';
import 'package:flutter/material.dart';

import 'local_widgets/linegradient.dart';

class InstructionsPage extends StatelessWidget {
  final double spaceFromTop = 60;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //space from top
              SizedBox(height: spaceFromTop),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  underlineText(context),
                  SizedBox(height: spaceFromTop - 10),
                  iconHeading(
                      icon: Icons.lock,
                      heading: "create spaces",
                      body: "Be in control of your conversations."),
                  SizedBox(height: spaceFromTop - 10),
                  iconHeading(
                      icon: Icons.library_add_check_outlined,
                      heading: "assign tasqs",
                      body:
                          "reward your patrons based on the milestones they complete."),
                  SizedBox(height: spaceFromTop - 10),
                  iconHeading(
                      icon: Icons.security_rounded,
                      heading: "privacy focused",
                      body:
                          "all the chats and tasqs are 100% end-to-end encrypted, with privacy built into our DNA."),
                ],
              ),
              SizedBox(height: spaceFromTop),
              nextButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget underlineText(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's get started",
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(height: 5.0),
        LineGradient(width: 120.0),
      ],
    );
  }

  Widget iconHeading({IconData icon, String heading, String body}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 4),
              child: Icon(
                icon,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$heading",
                  style: TextStyle(
                    fontFamily: Strings.primaryFontName,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 6.0),
                LineGradient(width: 70.0),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            "$body",
            style: TextStyle(
              fontFamily: Strings.primaryFontName,
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  nextButton(context) {
    return Center(
      child: CustomButton(
        text: 'next',
        borderRadiusValue: 23.0,
        borderColor: MyColors.primaryColor,
        borderWidth: 3.0,
        textColor: Colors.black,
        fontWeight: FontWeight.bold,
        width: MediaQuery.of(context).size.width / 2.2,
        height: 45,
        fontSize: 19.0,
        onTap: () => Utils.navigateAndReplacePageRoute(
          route: AppData.userType == UserType.USER
              ? UserBottomNavBarRoute
              : AdminBottomNavBarRoute,
        ),
      ),
    );
  }
}
