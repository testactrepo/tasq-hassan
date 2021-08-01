import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/viewmodel/task_model.dart';
import 'package:tasq/views/baseview.dart';
import 'package:tasq/views/user/home/local_widgets/usertasklist.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:flutter/material.dart';

class UserExploreView extends StatefulWidget {
  UserExploreView({Key key}) : super(key: key);

  @override
  _UserExploreViewState createState() => _UserExploreViewState();
}

class _UserExploreViewState extends State<UserExploreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'explore'),

      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: BaseView<TaskModel>(
          onModelReady: (model) => model.fetchTaskList(),
          builder: (_, model, __) => model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : UsersTasksListView(tasksList: model.tasksList),
        ),
      ),
    );
  }
}
