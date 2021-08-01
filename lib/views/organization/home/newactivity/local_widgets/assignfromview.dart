import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/viewmodel/assignfrom_model.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:tasq/views/baseview.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:flutter/material.dart';

class AssignFromView extends StatelessWidget {
  const AssignFromView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'assign from your team'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              Strings.assignFromPageTitle,
              style: Theme.of(context).textTheme.headline3,
            ),
            //space
            SizedBox(height: 20.0),
            //team members list
            buildTeamMembersList(),
          ],
        ),
      ),
    );
  }

  buildTeamMembersList() {
    return BaseView<AssignFromViewModel>(
      onModelReady: (model) => model.fetchTeamMembers(),
      builder: (_, model, __) => model.state == ViewState.Busy
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: model.teamMembersList.length,
              itemBuilder: (_, index) => TeamMemberListItem(
                user: model.teamMembersList[index],
              ),
            ),
    );
  }
}

class TeamMemberListItem extends StatelessWidget {
  final MyAppUser user;
  const TeamMemberListItem({@required this.user, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, user);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            //circle
            Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                shape: BoxShape.circle,
              ),
            ),
            //spcae
            SizedBox(width: 8.0),
            //team member name
            Text(
              user.name,
              style: MyTextStyle.heading18Black,
            ),
          ],
        ),
      ),
    );
  }
}
