import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/viewmodel/auth_model.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/naviation_services.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:tasq/views/auth/login_signup_pages.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';

class AdminProfile extends StatefulWidget {
  AdminProfile({Key key}) : super(key: key);

  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    MyAppUser user = locator<MyAppUser>();
    Organization org = locator<Organization>();
    return Scaffold(
      appBar: MyAppBar(
        title: 'profile',
        trailingIcon: Icon(Icons.chat_bubble_outline, color: Colors.black),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                //user name card view
                GestureDetector(
                  onTap: () async {
                    await locator<NavigationService>()
                        .navigateTo(EditDetailPageRoute);
                    setState(() {});
                  },
                  child: Card(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            user.isAdmin ? user.orgName : user.name,
                            style: MyTextStyle.heading18BoldWhite,
                          ),
                          Icon(FontAwesome.edit,
                              color: Colors.white, size: 20.0),
                        ],
                      ),
                    ),
                  ),
                ),
                //space
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () async {
                    await Utils.navigateTo(PendingRequestsPageRoute);
                    setState(() {});
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'pending requests',
                            style: MyTextStyle.heading16BoldBlack,
                          ),
                          Text(org?.numofpendingrequests?.toString() ?? '0',
                              style: MyTextStyle.dueInStyle),
                        ],
                      ),
                    ),
                  ),
                ),
                //space
                SizedBox(height: 20.0),
                //my accounts
                Container(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        itemView(
                            'my accounts', 'view and manage all your accounts',
                            onTap: () => Utils.navigateTo(MyAccountsPageRoute)),
                        Divider(
                          color: Colors.black,
                        ),
                        itemView('manage members',
                            'add/remove members and permissions',
                            onTap: () =>
                                Utils.navigateTo(ManageMembersPageRoute)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //logout button
          logoutButton(context),
        ],
      ),
    );
  }

  itemView(title, subtitle, {onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: Strings.primaryFontName),
            ),
            SizedBox(height: 10.0),
            Text(
              subtitle,
              style: TextStyle(fontFamily: Strings.primaryFontName),
            ),
          ],
        ),
      ),
    );
  }

  logoutButton(context) {
    return Positioned.fill(
      bottom: 40.0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            AuthModel authModel =
                Provider.of<AuthModel>(context, listen: false);
            authModel.signOut();
            //clear user and org record
            MyAppUser user = locator<MyAppUser>();
            user.update(MyAppUser());
            Organization org = locator<Organization>();
            org.update(Organization(numofpendingrequests: 0));
            Utils.navigateAndReplacePage(context, page: LoginSignupPages());
          },
          child: Container(
            width: 160.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 20.0),
                  Text(
                    'logout',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: Strings.primaryFontName),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
