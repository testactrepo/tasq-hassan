import 'package:tasq/core/model/task.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/organization/home/local_widgets/taskview.dart';
import 'package:tasq/views/organization/mytask/taskdetail_response/taskdetail_response.dart';
import 'package:flutter/material.dart';

class OrgTasksListView extends StatelessWidget {
  final List<Task> tasksList;
  final EdgeInsets padding;
  final int itemCount;
  const OrgTasksListView(
      {@required this.tasksList,
      this.padding: EdgeInsets.zero,
      this.itemCount,
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
                    page: TaskDetailAndResponse(task: tasksList[index]),
                  ),
                );
              },
            ),
          )
        : Container(height: 100, child: Center(child: Text('No task found')));
  }
}
