import 'package:tasq/core/model/task.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:tasq/views/organization/home/postpreview/local_widgets/timeago_widget.dart';
import 'package:flutter/material.dart';

class TaskPart1 extends StatelessWidget {
  final Task task;
  const TaskPart1({@required this.task, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${task?.taskname ?? ""}',
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(height: 20.0),
        timeAndAbout(context),
        SizedBox(height: 20.0),
        description(context),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget description(context) {
    return Text('${task.description}', style: MyTextStyle.bodyText17Black);
  }

  Widget timeAndAbout(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TimeAgoWidget(time: task.createdAt, size: 16),
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
                '${task.orgname}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
