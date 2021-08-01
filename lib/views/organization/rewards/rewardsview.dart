import 'package:tasq/utils/constants/dumydata.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:tasq/views/widgets/mycustomtab.dart';
import 'package:tasq/views/organization/home/local_widgets/orgtaskslistview.dart';
import 'package:tasq/views/organization/rewards/my_rewards_page.dart';
import 'package:tasq/views/widgets/rewardtabbar.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:tasq/views/widgets/circularbutton.dart';
import 'package:flutter/material.dart';

import 'explore_add_page.dart';

class AdminRewardsView extends StatefulWidget {
  AdminRewardsView({Key key}) : super(key: key);

  @override
  _AdminRewardsViewState createState() => _AdminRewardsViewState();
}

class _AdminRewardsViewState extends State<AdminRewardsView>
    with SingleTickerProviderStateMixin {
  //pageview init start
  PageController _pageController;
  //tab controller
  TabController _tabController;

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(0);
    _tabController.addListener(() {
      animateToPage(index: _tabController.index);
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'rewards'),
      floatingActionButton: floatingAddRewardButton(),
      body: Column(
        children: [
          MyTabBar(controller: _tabController),
          //pages
          Expanded(
            flex: 2,
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) {
                _tabController.animateTo(i);
                // setState(() {});
              },
              children: <Widget>[
                //first page (profile)
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: MyRewardsPage(),
                ),
                //second apge (recurring)
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: ExploreAndAddPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void animateToPage({@required index}) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  floatingAddRewardButton() {
    return FloatingActionButton(
      onPressed: () => Utils.navigateTo(AddNewRewardPageRoute),
      child: CircularButton(
        child: Text(
          '+',
          style: MyTextStyle.heading22BoldWhite,
        ),
      ),
    );
  }
}
