import 'package:tasq/core/model/organization.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/locator.dart';
import 'package:flutter/material.dart';

class AdminInfoBox extends StatelessWidget {
  final int totalcreatedtasks;
  final int totalunreadmsgs;
  const AdminInfoBox(
      {this.totalcreatedtasks: 0, this.totalunreadmsgs: 0, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Organization org = locator<Organization>();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //part 1
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //created tasqs
                CountInfoBox(number: org.totalcreatedtasks),
                //space
                SizedBox(height: 15.0),
                // unread msgs
                CountInfoBox(
                  title: 'unread msgs',
                  number: org.totalunreadmsgs,
                  icon: Icon(
                    Icons.email,
                    color: Colors.blue[800],
                  ),
                ),
              ],
            ),
            //part 2
            CompletedTaskBox(
              completedNumTasks: org.completedtasks,
              totalNumTasks: org.totalcreatedtasks,
            ),
          ],
        ),
      ),
    );
  }
}

class CountInfoBox extends StatelessWidget {
  final String title;
  final int number;
  final Icon icon;
  const CountInfoBox({
    this.title: 'created tasqs',
    this.number: 0,
    this.icon: const Icon(Icons.check_circle, color: Colors.green),
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Divider
        Container(
          color: Colors.black45,
          height: 50,
          width: 5,
        ),
        //space
        SizedBox(width: 15.0),
        //
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                icon,
                SizedBox(width: 10.0),
                Text(
                  '$number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: Strings.primaryFontName,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

class CompletedTaskBox extends StatelessWidget {
  final int completedNumTasks;
  final int totalNumTasks;
  const CompletedTaskBox(
      {this.completedNumTasks: 0, this.totalNumTasks: 0, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: MyColors.silver, width: 3.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(
              '$completedNumTasks/$totalNumTasks',
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 5.0),
            Text(
              '   tasq(s)\ncompleted',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
