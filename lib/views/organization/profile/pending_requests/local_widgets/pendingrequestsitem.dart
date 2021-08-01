import 'package:tasq/core/model/orgmembers.dart';
import 'package:tasq/utils/constants/appdata.dart';
import 'package:tasq/views/widgets/circularbutton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/web_symbols_icons.dart';

class PendingRequestItemView extends StatelessWidget {
  final OrgMember orgMembers;
  final Function(OrgMember) onAccept;
  final Function(OrgMember) onReject;
  const PendingRequestItemView(
      {@required this.orgMembers, this.onAccept, this.onReject, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 35.0,
          backgroundColor: Colors.white,
          backgroundImage: CachedNetworkImageProvider(
            orgMembers?.profileurl ?? AppData.userProfileUrl,
          ),
        ),
        title: Text(orgMembers.username),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //reject
            GestureDetector(
              onTap: () => onReject(orgMembers),
              child: CircularButton(
                radius: 35.0,
                bgColor: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child:
                      Icon(WebSymbols.cancel, size: 15.0, color: Colors.white),
                ),
              ),
            ),
            //space
            SizedBox(width: 10.0),
            //accept
            GestureDetector(
              onTap: () => onAccept(orgMembers),
              child: CircularButton(
                radius: 35.0,
                bgColor: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(Icons.check, size: 22.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
