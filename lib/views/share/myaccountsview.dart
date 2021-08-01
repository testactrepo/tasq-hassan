import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/orgmembers.dart';
import 'package:tasq/core/viewmodel/myaccounts_model.dart';
import 'package:tasq/utils/constants/appdata.dart';
import 'package:tasq/views/baseview.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:tasq/views/widgets/dropdownpopup.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyAccountsView extends StatefulWidget {
  MyAccountsView({Key key}) : super(key: key);

  @override
  _MyAccountsViewState createState() => _MyAccountsViewState();
}

class _MyAccountsViewState extends State<MyAccountsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'my accounts'),
      body: BaseView<MyAccountsModel>(
        onModelReady: (model) => model.loadAllAccounts(),
        builder: (_, model, __) => model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.accountsList.length,
                  itemBuilder: (_, index) => MyAccountListItem(
                    orgMember: model.accountsList[index],
                  ),
                ),
              ),
      ),
    );
  }
}

class MyAccountListItem extends StatelessWidget {
  final OrgMember orgMember;
  const MyAccountListItem({@required this.orgMember, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: CachedNetworkImageProvider(
            orgMember?.profileurl ?? AppData.userProfileUrl,
          ),
        ),
        title: Text(
          orgMember?.orgname ?? orgMember.username,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(orgMember.role),
        trailing: CustomDropDownPopup(
          optionsList: ['Change role'],
          onOption1Tap: () {},
        ),
      ),
    );
  }
}
