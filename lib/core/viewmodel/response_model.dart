import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/taskapplication.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/core/viewmodel/base_model.dart';
import 'package:tasq/utils/constants/firebasepath.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResponseModel extends BaseModel {
  FirestoreService fS = FirebaseFirestoreService();
  //data list
  List<TaskApplication> allResponses = [];
  List<TaskApplication> appliedProposalList = [];

  fetchAllResponses(String taskuid) async {
    setState(ViewState.Busy);
    allResponses = await fS.fetchAllResponses(taskuid);
    setState(ViewState.Idle);
  }

  fetchAppliedProposalList() async {
    setState(ViewState.Busy);
    appliedProposalList = await fS.fetchAppliedProposalList();
    setState(ViewState.Idle);
  }

  assignTaskToUser(String taskuid, String applicantuid) async {
    //assignToUserUID: update field in task collection
    fS.assignTaskToUser(taskuid, applicantuid);
    //allassignedtasks: update field in user collection
    FirebasePath.users(applicantuid)
        .update({'allassignedtasks': FieldValue.increment(1)});
  }

  deleteResponse(TaskApplication taskApplication) async {
    await fS.deleteResponse(taskApplication.reference.id);
    allResponses.remove(taskApplication);
    notifyListeners();
  }
}
