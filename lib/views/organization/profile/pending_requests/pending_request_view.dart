import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/viewmodel/members_model.dart';
import 'package:tasq/views/baseview.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'local_widgets/pendingrequestsitem.dart';

class PendingRequestView extends StatelessWidget {
  const PendingRequestView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'pending requests'),
      body: BaseView<MembersModel>(
        onModelReady: (model) => model.fetchMembersList(true),
        builder: (_, model, __) => model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                shrinkWrap: true,
                itemCount: model.userRequestsList.length,
                itemBuilder: (_, index) => PendingRequestItemView(
                  onAccept: (orgMember) =>
                      model.acceptRejectRequest(orgMember, true),
                  onReject: (orgMember) =>
                      model.acceptRejectRequest(orgMember, false),
                  orgMembers: model.userRequestsList[index],
                ),
              ),
      ),
    );
  }
}
