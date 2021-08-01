import 'package:tasq/core/model/taskapplication.dart';
import 'package:tasq/utils/constants/appdata.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:tasq/views/widgets/circularbutton.dart';
import 'package:tasq/views/widgets/dropdownpopup.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ResponseItemView extends StatelessWidget {
  final TaskApplication taskApplication;
  final VoidCallback onTap;
  final Function(String proposaluid) deleteResponse;
  final Function(String taskuid, String applicantuid) allocateTask;
  final bool disableDropdown;
  const ResponseItemView({
    @required this.taskApplication,
    this.onTap,
    this.deleteResponse,
    this.allocateTask,
    this.disableDropdown: false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //list tile
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: CircleAvatar(
              radius: 27.0,
              backgroundColor: Colors.white,
              backgroundImage: CachedNetworkImageProvider(
                taskApplication?.applicantDP ?? AppData.userProfileUrl,
              ),
            ),
            title: Text(taskApplication.tasktitle,
                style: MyTextStyle.heading18BoldBlack),
            subtitle: Row(children: [
              CircularButton(
                radius: 20.0,
                child: Text(
                  't',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Text('${taskApplication.taskpoints} tasQ points')
            ]),
            trailing: !disableDropdown
                ? CustomDropDownPopup(
                    onOption1Tap: () => allocateTask(
                        taskApplication.taskuid, taskApplication.applicantUID),
                    onOption2Tap: () =>
                        deleteResponse(taskApplication.reference.id),
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(taskApplication.proposal),
          ),
          Divider(),
        ],
      ),
    );
  }
}
