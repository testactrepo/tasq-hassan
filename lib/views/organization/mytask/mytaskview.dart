import 'package:tasq/core/enum/taskstatus.dart';
import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/viewmodel/task_model.dart';
import 'package:tasq/views/organization/home/local_widgets/orgtaskslistview.dart';
import 'package:tasq/views/widgets/rewardtabbar.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:flutter/material.dart';

import '../../baseview.dart';

class MyTasksView extends StatefulWidget {
  MyTasksView({Key key}) : super(key: key);

  @override
  _MyTasksViewState createState() => _MyTasksViewState();
}

class _MyTasksViewState extends State<MyTasksView>
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
      appBar: MyAppBar(title: 'my tasks'),
      body: Column(
        children: [
          MyTabBar(
            leftTabTitle: 'my postings',
            rightTabTitle: 'history',
            controller: _tabController,
          ),
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
                  child: BaseView<TaskModel>(
                    onModelReady: (model) => model.fetchMyOrgTaskList(),
                    builder: (_, model, __) => model.state == ViewState.Busy
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : OrgTasksListView(
                            padding: EdgeInsets.all(15.0),
                            tasksList: model.tasksList,
                          ),
                  ),
                ),
                //second apge (recurring)
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: BaseView<TaskModel>(
                    onModelReady: (model) => model.fetchMyOrgTaskList(
                        taskstatus: TaskStatus.COMPLETE),
                    builder: (_, model, __) => model.state == ViewState.Busy
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : OrgTasksListView(
                            padding: EdgeInsets.all(15.0),
                            tasksList: model.tasksList,
                          ),
                  ),
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
}
