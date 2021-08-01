import 'package:tasq/core/viewmodel/auth_model.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/auth/auth_widget.dart';
import 'package:tasq/views/user/explore/userexploreview.dart';
import 'package:tasq/views/user/home/homeview.dart';
import 'package:tasq/views/user/mytasks/mytasks.dart';
import 'package:tasq/views/user/profile/userprofileview.dart';
import 'package:tasq/views/user/rewards/userrewardsview.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class UserBottomNavBarView extends StatefulWidget {
  UserBottomNavBarView({Key key}) : super(key: key);

  @override
  _UserBottomNavBarViewState createState() => _UserBottomNavBarViewState();
}

class _UserBottomNavBarViewState extends State<UserBottomNavBarView> {
  final PageStorageBucket bucket = PageStorageBucket();
  int _selectedIndex = 0;

  AuthModel authModel;

  @override
  Widget build(BuildContext context) {
    authModel = Provider.of<AuthModel>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.black,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.explore,
                  text: 'explore',
                ),
                GButton(
                  icon: Octicons.gift,
                  text: 'rewards',
                ),
                GButton(
                  icon: FontAwesome.check,
                  text: 'my tasks',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: PageStorage(
        child: getPage(_selectedIndex),
        bucket: bucket,
      ),
    );
  }

  getPage(index) {
    if (index == 0)
      return UserHomeView(key: PageStorageKey('Page1'));
    else if (index == 1)
      return UserExploreView(key: PageStorageKey('Page2'));
    else if (index == 2)
      return UserRewardView(key: PageStorageKey('Page3'));
    else if (index == 3)
      return MyUserTaskView(key: PageStorageKey('Page4'));
    else if (index == 4) return UserProfileView(key: PageStorageKey('Page5'));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
