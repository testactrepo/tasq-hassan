import 'package:tasq/core/model/chatroom.dart';
import 'package:tasq/core/model/organization.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/organization/mytask/local_widgets/responseitemview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chatdetail_page.dart';

class ThreadView extends StatelessWidget {
  const ThreadView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatrooms = Provider.of<List<ChatRoom>>(context);
    Organization org = locator<Organization>();

    return ListView.builder(
        shrinkWrap: true,
        itemCount: chatrooms.length,
        itemBuilder: (_, index) {
          ChatRoom chatRoom = chatrooms[index];
          return ResponseItemView(
            taskApplication: chatrooms[index].taskApplication,
            disableDropdown: true,
            onTap: () => Utils.navigateToPage(
              context,
              page: ChatDetailPage(
                name: otherUserName(
                    chatRoom.members, chatRoom.membersname, org.uid),
                profileurl: otherUserProfileUrl(
                    chatRoom.profileurls, chatRoom.members, org.uid),
                currentuseruid: org.uid,
                otheruserid: otheruseruid(chatRoom.members, org.uid),
                isUnreadMsges: Utils.isUnreadMsg(chatRoom, org.uid),
                chatRoom: chatRoom,
              ),
            ),
          );
        });
  }
}

otherUserProfileUrl(profiles, members, myuid) {
  if (members[0] == myuid)
    return profiles[1];
  else
    return profiles[0];
}

otheruseruid(members, myuid) {
  if (members[0] == myuid) return members[1];
  return members[0];
}

otherUserName(members, membersname, myuid) {
  if (members[0] == myuid) return membersname[1];
  return membersname[0];
}
