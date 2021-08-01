import 'package:tasq/core/model/task.dart';
import 'package:tasq/utils/constants/appdata.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:tasq/views/widgets/circularbutton.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TaskView extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  const TaskView({@required this.task, this.onTap, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: MyColors.taskviewBGColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //first row
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    task?.orgProfileUrl ?? AppData.orgProfileUrl,
                  ),
                ),
                // CachedNetworkImage(
                //   fit: BoxFit.cover,
                //   imageUrl: task?.orgProfileUrl ?? AppData.orgProfileUrl,
                //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                //       CircularProgressIndicator(
                //           value: downloadProgress.progress),
                //   errorWidget: (context, url, error) =>
                //       Icon(Icons.error, color: MyColors.taskviewTextColor),
                // ),
                title: Text(
                  task.taskname,
                  style: MyTextStyle.heading18BoldWhite,
                ),
                subtitle: Text(
                  task.orgname,
                  style: MyTextStyle.subtitleWhite,
                ),
              ),
              //space
              SizedBox(height: 8.0),
              //second row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'status',
                    style: MyTextStyle.heading15NormalWhite,
                  ),
                  Text(
                    'number of responses',
                    style: MyTextStyle.heading15NormalWhite,
                  ),
                ],
              ),
              //space
              SizedBox(height: 8.0),
              //third row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.status,
                    style: MyTextStyle.heading15BoldWhite,
                  ),
                  Text(
                    '${task?.numberofresponses ?? 0}',
                    style: MyTextStyle.heading15BoldWhite,
                  ),
                ],
              ),
              //space
              SizedBox(height: 8.0),
              //fourth row
              Container(
                width: 150.0,
                decoration: BoxDecoration(
                  color: Color(0xff050091),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularButton(
                        radius: 24.0,
                        child: Text(
                          't+',
                          style: MyTextStyle.normal13WhiteBold,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        '${task.pointsOffered}  points',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
