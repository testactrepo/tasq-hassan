import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/viewmodel/myrewards_model.dart';
import 'package:tasq/utils/constants/dumydata.dart';
import 'package:tasq/views/baseview.dart';
import 'package:tasq/views/organization/rewards/explore_add_page.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:tasq/views/widgets/rewarditemview.dart';
import 'package:tasq/views/widgets/rewardtabbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserRewardView extends StatefulWidget {
  UserRewardView({Key key}) : super(key: key);

  @override
  _UserRewardViewState createState() => _UserRewardViewState();
}

class _UserRewardViewState extends State<UserRewardView>
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
        body: Column(children: [
          MyTabBar(
            leftTabTitle: 'collected rewards',
            rightTabTitle: 'redeem',
            controller: _tabController,
          ),
          Expanded(
            flex: 2,
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) {
                _tabController.animateTo(i);
              },
              children: <Widget>[
                //first page (profile)
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: BaseView<MyRewardsModel>(
                    onModelReady: (model) => model.fetchMyCollectedRewards(),
                    builder: (_, model, __) => model.state == ViewState.Busy
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ListView.builder(
                              itemCount: model.rewardList.length,
                              itemBuilder: (_, index) => RewardItemView(
                                  reward: model.rewardList[index]),
                            ),
                          ),
                  ),
                ),
                //second apge (recurring)
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: ExploreAndAddPage(),
                ),
              ],
            ),
          )
        ]));
  }

  void animateToPage({@required index}) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
