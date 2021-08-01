import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/viewmodel/members_model.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/organization/profile/manage_members/local_widget/members_item_view.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:flutter/material.dart';
import '../../../baseview.dart';

class ManageMembersView extends StatelessWidget {
  const ManageMembersView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoleKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoleKey,
      appBar: MyAppBar(title: 'manage members'),
      body: BaseView<MembersModel>(
        onModelReady: (model) => model.fetchMembersList(false),
        builder: (_, model, __) => model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                shrinkWrap: true,
                itemCount: model.membersList.length,
                itemBuilder: (_, index) => MembersItemView(
                  orgMember: model.membersList[index],
                  onRemove: (orgMember) {
                    model.removeOrgMember(orgMember);
                    showSnackBar(scaffoleKey);
                  },
                  makeUserAdmin: (orgMember) {
                    model.changeOrgMemberRole(orgMember);
                    showSnackBar(scaffoleKey);
                  },
                ),
              ),
      ),
    );
  }

  showSnackBar(scaffoldKey) {
    Utils.showSnackbar(
        scaffoldKey: scaffoldKey, message: 'Operation successfull');
  }
}
