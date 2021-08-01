import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/orgmembers.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/core/viewmodel/base_model.dart';
import 'package:tasq/utils/locator.dart';

class MyAccountsModel extends BaseModel {
  MyAppUser user = locator<MyAppUser>();
  List<OrgMember> accountsList = [];

  FirestoreService fs = FirebaseFirestoreService();

  loadAllAccounts() async {
    setState(ViewState.Busy);
    accountsList = await fs.fetchMyAccountsList();
    setState(ViewState.Idle);
  }
}
