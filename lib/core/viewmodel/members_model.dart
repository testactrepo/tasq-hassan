import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/orgmembers.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/core/viewmodel/base_model.dart';

class MembersModel extends BaseModel {
  FirestoreService firestoreService = FirebaseFirestoreService();
  //data
  List<OrgMember> userRequestsList = [];
  List<OrgMember> membersList = [];

  void fetchMembersList(bool request) async {
    setState(ViewState.Busy);
    if (request)
      userRequestsList = await firestoreService.fetchMembers(request);
    else
      membersList = await firestoreService.fetchMembers(request);
    setState(ViewState.Idle);
  }

  acceptRejectRequest(OrgMember orgMembers, bool accept) {
    //change status in orgMembers collection to 1 (accept)
    //reduce pendingrequest value in org collection
    firestoreService.acceptRejectMemberRequest(orgMembers.reference.id, accept);
    userRequestsList.remove(orgMembers);
    notifyListeners();
  }

  removeOrgMember(OrgMember orgMember) {
    firestoreService.removeOrgMember(orgMember.reference.id);
    membersList.remove(orgMember);
    notifyListeners();
  }

  changeOrgMemberRole(OrgMember orgMember) {
    //#TODO: check user collection isAdmin and orguid, change if needed
    String newRole = orgMember.role == 'user' ? 'admin' : 'user';
    firestoreService.changeOrgMemberRole(orgMember.reference.id, newRole);
    //find index
    int index = membersList.indexOf(orgMember);
    orgMember.role = newRole;
    membersList[index] = orgMember;
    notifyListeners();
  }
}
