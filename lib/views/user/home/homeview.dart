import 'package:tasq/core/enum/taskstatus.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/viewmodel/task_model.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/baseview.dart';
import 'package:tasq/views/organization/messages/messagesview.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'local_widgets/userinfobox.dart';
import 'local_widgets/usertasklist.dart';

class UserHomeView extends StatefulWidget {
  UserHomeView({Key key}) : super(key: key);

  @override
  _UserHomeViewState createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView> {
  final user = locator<MyAppUser>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              //admin info box
              UserInfoBox(),
              //tasks heading
              myHeadingRow(),
              //task view
              BaseView<TaskModel>(
                onModelReady: (model) =>
                    model.fetchUserTaskList(taskstatus: TaskStatus.ALLOTED),
                builder: (_, model, __) => UsersTasksListView(
                  itemCount: 1,
                  tasksList: model.tasksList,
                  myTask: true,
                ),
              ),
              //explore opportunities heading
              myHeadingRow(leadingtitle: 'explore opportunities'),
              //task view
              BaseView<TaskModel>(
                onModelReady: (model) => model.fetchTaskList(),
                builder: (_, model, __) => UsersTasksListView(
                  itemCount: 1,
                  tasksList: model.tasksList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  appBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      title: Text(
        'home',
        style: Theme.of(context).textTheme.headline3,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Typicons.comment,
            color: Colors.black,
          ),
          onPressed: () =>
              Utils.navigateToPage(context, page: MessagesPageView()),
        ),
      ],
    );
  }

  myHeadingRow({String leadingtitle: 'manage tasks', VoidCallback onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leadingtitle,
          style: Theme.of(context).textTheme.headline4,
        ),
        TextButton(onPressed: onSeeAll, child: Text('see all')),
      ],
    );
  }
}
