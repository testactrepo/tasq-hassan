import 'package:tasq/core/model/chatroom.dart';
import 'package:tasq/core/model/message.dart';
import 'package:tasq/core/model/task.dart';
import 'package:tasq/core/model/taskapplication.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/user/home/seetask/local_widgets/taskpart2.dart';
import 'package:tasq/views/widgets/custombutton.dart';
import 'package:flutter/material.dart';

import 'local_widgets/taskpart1.dart';

class SeeTaskView extends StatefulWidget {
  final Task taskData;
  final bool disableApply;
  const SeeTaskView(
      {@required this.taskData, this.disableApply: false, Key key})
      : super(key: key);

  @override
  _SeeTaskViewState createState() => _SeeTaskViewState();
}

class _SeeTaskViewState extends State<SeeTaskView> {
  bool applyBtnClicked = false;
  //textfield
  final proposalController = TextEditingController();
  //
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TaskPart1(task: widget.taskData),
                    applyBtnClicked
                        ? proposalTextBox()
                        : TaskPart2(task: widget.taskData),
                    widget.disableApply
                        ? Container(width: 0, height: 0)
                        : applyButton(),
                  ],
                ),
              ),
            ),
            //cross icon
            crossIconTopCorner(context),
          ],
        ),
      ),
    );
  }

  proposalTextBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.0),
        Text(
          'write your proposal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15.0),
        TextFormField(
          maxLines: 10,
          controller: proposalController,
          decoration: InputDecoration(
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: MyColors.primaryColor)),
          ),
        ),
      ],
    );
  }

  applyButton() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: CustomButton(
        color: Colors.blue,
        disableBorder: true,
        width: 250.0,
        height: 60.0,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        text: applyBtnClicked ? 'CONFIRM' : 'APPLY',
        onTap: () {
          if (!applyBtnClicked) {
            applyBtnClicked = true;
            setState(() {});
          } else {
            MyAppUser user = locator<MyAppUser>();
            TaskApplication taskApp = TaskApplication();
            taskApp.applicantUID = user.uid;
            taskApp.applicantName = user.name;
            taskApp.applicantDP = user.profileUrl;
            taskApp.proposal = proposalController.text.trim();
            taskApp.taskpoints = widget.taskData.pointsOffered;
            taskApp.taskuid = widget.taskData.reference.id;
            taskApp.tasktitle = widget.taskData.taskname;
            //apply to post
            FirestoreService fS = FirebaseFirestoreService();
            fS.sendProposalToTask(taskApp);
            //also send proposal as msg
            ChatRoom chatRoom = ChatRoom();
            chatRoom.members = [user.uid, widget.taskData.orguid];
            chatRoom.profileurls = [
              user.profileUrl,
              widget.taskData.orgProfileUrl
            ];
            chatRoom.membersname = [user.name, widget.taskData.orgname];
            chatRoom.updatedAt = DateTime.now();
            chatRoom.taskApplication = taskApp;
            //message
            Message msg = Message(
                msgTxt: proposalController.text.trim(),
                sendAt: DateTime.now(),
                sendBy: user.uid);
            //add as recent msg to chatroom
            chatRoom.recentMsg = msg;
            fS.sendMessage(
              chatRoom,
              Utils.getCombineUid(user.uid, widget.taskData.orguid),
              msg,
            );
            Utils.showSnackbar(
                scaffoldKey: scaffoldKey, message: 'Proposal successfuly send');
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  crossIconTopCorner(context) {
    return Positioned(
      top: 20.0,
      right: 20.0,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.cancel, color: Colors.black),
      ),
    );
  }
}
