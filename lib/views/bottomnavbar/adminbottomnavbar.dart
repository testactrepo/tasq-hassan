import 'package:tasq/core/viewmodel/auth_model.dart';
import 'package:tasq/views/organization/home/adminhome.dart';
import 'package:tasq/views/organization/mytask/mytaskview.dart';
import 'package:tasq/views/organization/profile/profile.dart';
import 'package:tasq/views/organization/rewards/rewardsview.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class AdminBottomNavBarView extends StatefulWidget {
  AdminBottomNavBarView({Key key}) : super(key: key);

  @override
  _AdminBottomNavBarViewState createState() => _AdminBottomNavBarViewState();
}

class _AdminBottomNavBarViewState extends State<AdminBottomNavBarView> {
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.black,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
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
      return AdminHomeView(key: PageStorageKey('Page1'));
    else if (index == 1)
      return AdminRewardsView(key: PageStorageKey('Page2'));
    else if (index == 2)
      return MyTasksView(key: PageStorageKey('Page3'));
    else
      return AdminProfile();
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
}
