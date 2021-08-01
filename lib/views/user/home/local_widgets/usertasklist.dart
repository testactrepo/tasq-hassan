import 'package:tasq/core/model/task.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/organization/home/local_widgets/taskview.dart';
import 'package:tasq/views/user/home/seetask/seetaskview.dart';
import 'package:flutter/material.dart';

class UsersTasksListView extends StatelessWidget {
  final List<Task> tasksList;
  final EdgeInsets padding;
  final int itemCount;
  final bool myTask;
  const UsersTasksListView(
      {@required this.tasksList,
      this.padding: EdgeInsets.zero,
      this.itemCount,
      this.myTask: false,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tasksList.length > 0
        ? Padding(
            padding: padding,
            child: ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              itemCount: (itemCount != null && itemCount < tasksList.length)
                  ? itemCount
                  : tasksList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TaskView(
                  task: tasksList[index],
                  onTap: () => Utils.navigateToPage(
                    context,
                    page: SeeTaskView(
                        taskData: tasksList[index], disableApply: myTask),
                  ),
                );
              },
            ),
          )
        : Container(height: 100, child: Center(child: Text('No task found')));
  }
}
