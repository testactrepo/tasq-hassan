import 'package:tasq/core/model/chatroom.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/organization/messages/chatdetail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomListView extends StatelessWidget {
  const ChatRoomListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatrooms = Provider.of<List<ChatRoom>>(context);

    return chatrooms.length != 0
        ? ListView.builder(
            itemCount: chatrooms.length,
            shrinkWrap: true,
            itemBuilder: (_, index) => UserListItem(chatRoom: chatrooms[index]),
          )
        : Center(child: Text('No chat history'));
  }
}

class UserListItem extends StatelessWidget {
  final ChatRoom chatRoom;
  const UserListItem({@required this.chatRoom, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyAppUser user = locator<MyAppUser>();
    // Organization org = locator<Organization>();
    // print('orguid: ' + org.uid);

    return InkWell(
      onTap: () => Utils.navigateToPage(
        context,
        page: ChatDetailPage(
          name: otherUserName(chatRoom.members, chatRoom.membersname,
              user.isAdmin ? user.orgId : user.uid),
          profileurl: otherUserProfileUrl(chatRoom.profileurls,
              chatRoom.members, user.isAdmin ? user.orgId : user.uid),
          currentuseruid: user.isAdmin ? user.orgId : user.uid,
          otheruserid: otheruseruid(
              chatRoom.members, user.isAdmin ? user.orgId : user.uid),
          isUnreadMsges:
              Utils.isUnreadMsg(chatRoom, user.isAdmin ? user.orgId : user.uid),
          chatRoom: chatRoom,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            //circle
            Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                border: Border.all(width: 4.0, color: Colors.black45),
                shape: BoxShape.circle,
              ),
            ),
            //spcae
            SizedBox(width: 8.0),
            //team member name
            Text(
                otherUserName(chatRoom.members, chatRoom.membersname,
                    user.isAdmin ? user.orgId : user.uid),
                style: MyTextStyle.heading18Black),
            //spacer
            Spacer(),
            //unread msges box
            Utils.isUnreadMsg(chatRoom, user.isAdmin ? user.orgId : user.uid)
                ? RawMaterialButton(
                    onPressed: () {},
                    child: Text(
                      '${chatRoom.unreadmessagescount}',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: CircleBorder(),
                    fillColor: MyColors.primaryColor,
                  )
                : Container(width: 0.0),
          ],
        ),
      ),
    );
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
