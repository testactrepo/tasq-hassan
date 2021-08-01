import 'package:tasq/core/model/task.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:tasq/views/widgets/circularbutton.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class TaskPart2 extends StatelessWidget {
  final Task task;
  const TaskPart2({@required this.task, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        task.rewarduid == null ? Container() : rewardOfferedWidget(context),
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
          task.pointsOffered.toString(),
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
          Jiffy(task.duein).startOf(Units.HOUR).fromNow(),
          style: MyTextStyle.dueInStyle,
        ),
      ],
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
                  task.rewardtitle,
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
}
