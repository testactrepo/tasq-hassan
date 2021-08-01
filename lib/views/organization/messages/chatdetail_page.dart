import 'package:tasq/core/model/chatroom.dart';
import 'package:tasq/core/model/message.dart';
import 'package:tasq/core/services/firestorestreamservice.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'local_widgets/chatview.dart';

class ChatDetailPage extends StatefulWidget {
  final String name;
  final dynamic profileurl;
  final String currentuseruid;
  final String otheruserid;
  final bool isUnreadMsges;
  final ChatRoom chatRoom;

  ChatDetailPage({
    @required this.name,
    @required this.profileurl,
    @required this.isUnreadMsges,
    this.currentuseruid,
    this.otheruserid,
    this.chatRoom,
    Key key,
  }) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Message>>.value(
      initialData: [],
      value: FirestoreStreamService().messagesListStream(
          combineuid:
              Utils.getCombineUid(widget.currentuseruid, widget.otheruserid)),
      child: Scaffold(
        appBar: MyAppBar(title: widget.name),
        body: ChatView(
          name: widget.name,
          profileurl: widget.profileurl,
          otheruseruid: widget.otheruserid,
          unreadMsg: widget.isUnreadMsges,
          chatRoom: widget.chatRoom,
        ),
      ),
    );
  }
}
