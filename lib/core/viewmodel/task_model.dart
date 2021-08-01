import 'package:tasq/core/enum/taskstatus.dart';
import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/task.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/core/viewmodel/base_model.dart';

class TaskModel extends BaseModel {
  FirestoreService fs = FirebaseFirestoreService();

  List<Task> tasksList = [];

  removeTaskFromList(Task task) {
    tasksList.remove(task);
    notifyListeners();
  }

  addNewTask(Task task) async {
    setState(ViewState.Busy);
    await fs.addNewTask(task);
    tasksList.add(task);
    setState(ViewState.Idle);
  }

  fetchTaskList({taskstatus = TaskStatus.NOTALLOTED}) async {
    setState(ViewState.Busy);
    tasksList = await fs.fetchTasksList(taskstatus);
    setState(ViewState.Idle);
  }

  fetchUserTaskList({taskstatus = TaskStatus.NOTALLOTED}) async {
    setState(ViewState.Busy);
    tasksList = await fs.fetchUserTasksList(taskstatus);
    setState(ViewState.Idle);
  }

  fetchMyOrgTaskList({taskstatus = TaskStatus.NOTALLOTED}) async {
    setState(ViewState.Busy);
    tasksList = await fs.fetchMyOrgTasksList(taskstatus);
    setState(ViewState.Idle);
  }
}
