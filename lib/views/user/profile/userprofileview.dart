import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/viewmodel/auth_model.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/naviation_services.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/auth/login_signup_pages.dart';
import 'package:tasq/views/organization/messages/messagesview.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key key}) : super(key: key);

  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    MyAppUser user = locator<MyAppUser>();
    return Scaffold(
      appBar: MyAppBar(
        title: 'profile',
        trailingIcon: GestureDetector(
            onTap: () =>
                Utils.navigateToPage(context, page: MessagesPageView()),
            child: Icon(Icons.chat_bubble_outline, color: Colors.black)),
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
                            user.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: Strings.primaryFontName,
                            ),
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
                //my accounts
                GestureDetector(
                  onTap: () => Utils.navigateTo(MyAccountsPageRoute),
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'my accounts',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: Strings.primaryFontName,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'view and manage all your accounts',
                              style: TextStyle(
                                  fontFamily: Strings.primaryFontName),
                            ),
                          ],
                        ),
                      ),
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
                    style: TextStyle(fontWeight: FontWeight.bold,
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
