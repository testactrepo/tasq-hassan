import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/reward.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/core/viewmodel/task_model.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:tasq/views/organization/home/local_widgets/orgtaskslistview.dart';
import 'package:tasq/views/organization/messages/messagesview.dart';
import 'package:tasq/views/widgets/circularbutton.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';

import '../../baseview.dart';
import 'local_widgets/admininfobox.dart';

class AdminHomeView extends StatefulWidget {
  AdminHomeView({Key key}) : super(key: key);

  @override
  _AdminHomeViewState createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  Organization organization;
  @override
  Widget build(BuildContext context) {
    organization = locator<Organization>();
    return Scaffold(
      appBar: appBar(),
      floatingActionButton: floatingAddTaskButton(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              //admin info box
              AdminInfoBox(),
              //tasks heading
              manageTasksHeading(),
              //task view
              BaseView<TaskModel>(
                onModelReady: (model) => model.fetchMyOrgTaskList(),
                builder: (_, model, __) => model.state == ViewState.Busy
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : OrgTasksListView(
                        itemCount: 2, tasksList: model.tasksList),
              ),
            ],
          ),
        ),
      ),
    );
  }

  appBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Text(
        organization.orgName,
        style: Theme.of(context).textTheme.headline3,
      ),
      actions: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 13.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            gradient: MyColors.adminGradient,
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0, left: 8.0),
            child: Row(
              children: [
                Icon(Icons.bolt, color: Colors.white, size: 18.0),
                SizedBox(width: 5.0),
                Text(
                  "admin",
                  style: TextStyle(
                      fontFamily: Strings.primaryFontName,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Typicons.comment,
            color: Colors.black,
          ),
          onPressed: () =>
              Utils.navigateToPage(context, page: MessagesPageView()),
        ),
      ],
    );
  }

  manageTasksHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'manage tasks',
          style: Theme.of(context).textTheme.headline4,
        ),
        TextButton(onPressed: null, child: Text('see all')),
      ],
    );
  }

  floatingAddTaskButton() {
    return FloatingActionButton(
      onPressed: () async {
        FirestoreService fS = FirebaseFirestoreService();
        List<Reward> rewardList = await fS.fetchRewardsList();
        Utils.navigateTo(NewActivityPageRoute, arguments: rewardList);
      },
      child: CircularButton(),
    );
  }
}
