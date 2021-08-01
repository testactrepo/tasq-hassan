import 'package:tasq/core/model/taskapplication.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:tasq/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class MyTaskItemView extends StatelessWidget {
  final TaskApplication taskApplication;
  const MyTaskItemView({@required this.taskApplication, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyAppUser user = locator<MyAppUser>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //row 1
        Row(
          children: [
            Text(taskApplication.applicantName,
                style: MyTextStyle.heading16BoldBlack),
            Spacer(),
            Text(
              Jiffy(taskApplication.appliedat).fromNow(),
              style: TextStyle(fontSize: 10.0),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
        Text(
          taskApplication.tasktitle,
          style: MyTextStyle.heading14BoldBlack,
        ),
        SizedBox(height: 10.0),
        Text.rich(
          TextSpan(
            text: user.uid == taskApplication.applicantUID
                ? 'You: '
                : taskApplication.applicantName,
            style: MyTextStyle.heading14BoldBlack,
            children: [
              TextSpan(
                text: taskApplication.proposal,
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        // Text(taskApplication.proposal),
        SizedBox(height: 10.0),

        Divider(color: Colors.black),
      ],
    );
  }
}
