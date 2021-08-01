import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class TimeAgoWidget extends StatelessWidget {
  final DateTime time;
  final bool withWatch;
  final double size;
  final Color textColor;
  TimeAgoWidget(
      {this.time,
      this.withWatch = true,
      this.size,
      this.textColor = Colors.black});
  @override
  Widget build(BuildContext context) {
    double kSize = size ?? 10;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        withWatch
            ? Padding(
                padding: EdgeInsets.only(right: kSize - 5),
                child: Icon(
                  Icons.schedule,
                  size: (kSize / 2) + kSize,
                ),
              )
            : Container(),
        Text(
          Jiffy(time).fromNow(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
