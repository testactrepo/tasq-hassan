import 'package:tasq/core/model/chatroom.dart';
import 'package:tasq/core/model/message.dart';
import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'messageslist.dart';

class ChatView extends StatefulWidget {
  final name;
  final profileurl;
  final otheruseruid;
  final bool unreadMsg; //only for reciver msg read state should updated
  final ChatRoom chatRoom;

  ChatView({
    @required this.name,
    @required this.profileurl,
    @required this.otheruseruid,
    @required this.unreadMsg,
    this.chatRoom,
    Key key,
  }) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final scrollController = ScrollController();
  final msgController = TextEditingController();
  Organization organization;
  MyAppUser user;
  var myuid;

  bool unreadMsg;

  @override
  void initState() {
    unreadMsg = widget.unreadMsg;

    super.initState();
    scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      print("reach the bottom");
      setState(() {
        print("reach the bottom");
        // _limit += _limitIncrement;
      });
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      print("reach the top");
      setState(() {
        print("reach the top");
      });
    }
  }

  @override
  void dispose() {
    msgController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<List<Message>>(context) ?? [];
    organization = locator<Organization>();
    user = locator<MyAppUser>();
    myuid = user.isAdmin ? user.orgId : user.uid;

    if (messages.length != 0) {
      Message message = messages[0];
      if (message != null) updateUnreadMsgesState(message.sendBy);
    }

    return Column(
      children: [
        Expanded(
          child: MessagesList(
            messageslist: messages,
            myuid: myuid,
            profileurl: widget.profileurl,
            name: widget.name,
            otheruseruid: widget.otheruseruid,
            scrollController: scrollController,
          ),
        ),
        sendMessageBoxWidget(),
      ],
    );
  }

  sendMessageBoxWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.35,
                // decoration: BoxDecoration(
                //   color: MyColors.highlightedColor,
                //   borderRadius: BorderRadius.all(Radius.circular(12.0)),
                // ),
                child: TextFormField(
                  controller: msgController,
                  maxLines: null, //auto grow
                  decoration: InputDecoration(
                    hintText: 'Type your message',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, right: 5),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (msgController.text.isNotEmpty) {
                  FirestoreService database = FirebaseFirestoreService();
                  //messsage
                  Message message = Message(
                      msgTxt: msgController.text,
                      sendBy: myuid,
                      sendAt: DateTime.now());
                  //chatroom
                  ChatRoom chatRoom = ChatRoom();
                  chatRoom.members = [myuid, widget.otheruseruid];
                  chatRoom.profileurls = [
                    user.isAdmin ? organization.profileUrl : user.profileUrl,
                    widget.profileurl
                  ];
                  chatRoom.recentMsg = message;
                  chatRoom.membersname = [
                    user.isAdmin ? user.orgName : user.name,
                    widget.name
                  ];
                  chatRoom.updatedAt = DateTime.now();
                  chatRoom.taskApplication = widget.chatRoom.taskApplication;
                  database.sendMessage(
                    chatRoom,
                    Utils.getCombineUid(myuid, widget.otheruseruid),
                    message,
                  );
                  msgController.clear();
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Icon(Icons.send, color: Colors.black, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateUnreadMsgesState(senderuid) {
    if (unreadMsg || senderuid != myuid) {
      print('update state');
      FirestoreService database = FirebaseFirestoreService();
      String chatroomuid = Utils.getCombineUid(myuid, widget.otheruseruid);
      print('myuid: ' + myuid);
      print('otheruseruid: ' + widget.otheruseruid);
      print('chatroomuid: ' + chatroomuid);
      database.updateUnreadMsgCount(chatroomuid);
      //update state
      unreadMsg = false;
      setState(() {});
    }
  }
}
