import 'package:tasq/core/model/message.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/utils/constants/appdata.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class MessagesList extends StatelessWidget {
  final List<Message> messageslist;
  final myuid;
  final otheruseruid;
  final profileurl;
  final String name;

  final scrollController;
  const MessagesList({
    @required this.messageslist,
    @required this.myuid,
    @required this.otheruseruid,
    @required this.scrollController,
    this.profileurl,
    this.name,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyAppUser user = locator<MyAppUser>();
    // Organization org = locator<Organization>();
    // print('myuid: ' + myuid);
    return messageslist.length != 0
        ? Padding(
            padding:
                const EdgeInsets.only(bottom: 30.0, left: 15.0, right: 15.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: messageslist.length,
              controller: scrollController,
              reverse: true,
              itemBuilder: (context, index) {
                final message = messageslist[index];
                print(message.sendBy);
                return Column(
                  children: [
                    //chatview
                    Align(
                      alignment: message.sendBy == myuid
                          ? Alignment.topRight
                          : Alignment.bottomLeft,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 150),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: message.sendBy == myuid
                              ? null
                              : CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: CachedNetworkImageProvider(
                                    profileurl != null
                                        ? profileurl
                                        : AppData.userProfileUrl,
                                  ),
                                ),
                          title: Text.rich(
                            TextSpan(
                              text: message.sendBy == myuid
                                  ? user.isAdmin
                                      ? user.orgName
                                      : user.name
                                  : name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text:
                                      '\t\t${Jiffy(message.sendAt).format("hh:mm a")}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13.0),
                                )
                              ],
                            ),
                          ),
                          subtitle: Text(message.msgTxt),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        : Container(width: 0, height: 0);
  }
}

class ChatContentView extends StatelessWidget {
  final Message message;
  final String myuid;
  const ChatContentView({
    @required this.message,
    @required this.myuid,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.sendBy == myuid ? Alignment.topRight : Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: message.sendBy == myuid
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 100,
            ),
            child: Card(
              color: message.sendBy == myuid ? Colors.lightBlue : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(message.msgTxt),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7.0, right: 7.0),
            child: Text(
              '${Jiffy(message.sendAt).format("hh:mm a")}',
              style: TextStyle(
                color: MyColors.highlightedColor,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
