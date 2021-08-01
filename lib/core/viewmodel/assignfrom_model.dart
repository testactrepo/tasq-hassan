import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/core/viewmodel/base_model.dart';

class AssignFromViewModel extends BaseModel {
  FirestoreService fs = FirebaseFirestoreService();
  //team members list
  List<MyAppUser> teamMembersList;

  fetchTeamMembers() async {
    setState(ViewState.Busy);
    teamMembersList = await fs.fetchTeamMembers();
    setState(ViewState.Idle);
  }
}
