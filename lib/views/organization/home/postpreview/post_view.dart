import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/task.dart';
import 'package:tasq/core/viewmodel/task_model.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import '../../../widgets/activity_post.dart';

class PostPreview extends StatefulWidget {
  final Task taskData;
  PostPreview({this.taskData});

  @override
  _PostPreviewState createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
  bool inProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PostDetail(taskData: widget.taskData),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: CustomButton(
                  color: Colors.blue,
                  disableBorder: true,
                  width: 250.0,
                  height: 60.0,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  text: 'CONFIRM AND POST',
                  onTap: () async {
                    final taskModel = locator<TaskModel>();
                    if (!inProgress) {
                      inProgress = true;
                      setState(() {});
                      await taskModel.addNewTask(widget.taskData);
                      Utils.navigateAndReplacePageRoute(
                          route: AdminBottomNavBarRoute);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  appBar(context) {
    return AppBar(
      centerTitle: false,
      leading: BackButton(
        color: Colors.black,
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'new activity',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }
}
