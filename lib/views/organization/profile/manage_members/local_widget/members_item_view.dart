import 'package:tasq/core/model/orgmembers.dart';
import 'package:tasq/views/widgets/dropdownpopup.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MembersItemView extends StatelessWidget {
  final OrgMember orgMember;
  final Function(OrgMember) onRemove;
  final Function(OrgMember) makeUserAdmin;
  const MembersItemView(
      {@required this.orgMember, this.makeUserAdmin, this.onRemove, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: orgMember.profileurl != null
          ? CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(orgMember.profileurl),
            )
          : null,
      title: Text(orgMember.username),
      subtitle: Text(orgMember.role),
      trailing: CustomDropDownPopup(
        optionsList: [
          'remove user',
          orgMember.role == 'user' ? 'make admin' : 'make user'
        ],
        onOption1Tap: () => onRemove(orgMember),
        onOption2Tap: () => makeUserAdmin(orgMember),
      ),
    );
  }
}
