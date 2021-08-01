import 'dart:ui';
import 'package:tasq/core/model/task.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:tasq/views/widgets/circularbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import '../organization/home/postpreview/local_widgets/timeago_widget.dart';

class PostDetail extends StatelessWidget {
  final Task taskData;
  PostDetail({this.taskData});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${taskData?.taskname ?? ""}',
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: 20.0),
          timeAndAbout(context),
          SizedBox(height: 20.0),
          description(context),
          SizedBox(height: 20.0),
          taskData.rewarduid == null
              ? Container()
              : rewardOfferedWidget(context),
          //point offered
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircularButton(
                  radius: 20.0,
                  child: Text('t', style: TextStyle(color: Colors.white))),
              SizedBox(width: 10),
              Text(
                'tasQ points',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Text(
            taskData.pointsOffered.toString(),
            style: MyTextStyle.pointsStyle,
          ),
          SizedBox(height: 15.0),

          //duein
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.timer),
              SizedBox(width: 10),
              Text(
                'due in',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Text(
            Jiffy(taskData.duein).startOf(Units.HOUR).fromNow(),
            style: MyTextStyle.dueInStyle,
          ),
        ],
      ),
    );
  }

  rewardOfferedWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.card_giftcard),
            SizedBox(width: 10),
            Text(
              'rewards offered',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              border: Border.all(
                width: 1.0,
                color: const Color(0xFFDC143D),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  taskData.rewardtitle,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 15.0),
      ],
    );
  }

  Widget description(context) {
    return Text('${taskData.description}', style: MyTextStyle.bodyText17Black);
  }

  Widget timeAndAbout(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TimeAgoWidget(time: taskData.createdAt, size: 16),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Icon(Icons.apartment_outlined),
            SizedBox(
              width: 14,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '${taskData.orgname}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String getExpiry(Timestamp expiry) {
    DateTime postDate = expiry.toDate();
    DateTime today = DateTime.now();
    int diff = postDate.difference(today).inDays;
    print("fst $diff");
    if (diff < 1) {
      int diff = postDate.difference(today).inHours;
      print("h $diff");
      return "$diff hours";
    } else {
      return "$diff days";
    }
  }
}
