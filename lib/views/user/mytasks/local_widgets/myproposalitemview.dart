import 'package:tasq/core/model/task.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/utils/constants/firebasepath.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/views/widgets/dropdownpopup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class MyProposalItemView extends StatelessWidget {
  final Task task;
  final VoidCallback onTaskCompleted;
  const MyProposalItemView({@required this.task, this.onTaskCompleted, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //row 1
        Row(
          children: [
            Text(task.orgname, style: MyTextStyle.heading16BoldBlack),
            Spacer(),
            Text(
              Jiffy(task.createdAt).fromNow(),
              style: TextStyle(fontSize: 10.0),
            ),
            CustomDropDownPopup(
              optionsList: ['Mark is completed'],
              onOption1Tap: () {
                FirestoreService fS = FirebaseFirestoreService();
                //update task status
                task.status = Strings.taskcompleted;
                fS.updateTaskRecord(task);
                //update user points, taskcompleted,
                //if reward is not null then add reward to user collection
                MyAppUser user = locator<MyAppUser>();
                user.points += task.pointsOffered;
                user.completedtasks += 1;
                if (task.rewarduid != null)
                  user.rewardsList.add({
                    "rewarduid": task.rewarduid,
                    "orguid": task.orguid,
                  });
                fS.updateUserRecord(user);
                //update organization completed task counter
                FirebasePath.organization(task.orguid)
                    .update({'completedtasks': FieldValue.increment(1)});
                onTaskCompleted();
              },
              onOption2Tap: () {},
            ),
          ],
        ),
        Text(
          task.taskname,
          style: MyTextStyle.heading14BoldBlack,
        ),
        SizedBox(height: 10.0),
        Text.rich(
          TextSpan(
            text: task.orgname,
            style: MyTextStyle.heading14BoldBlack,
            children: [
              TextSpan(
                text: ': ' + task.description,
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
