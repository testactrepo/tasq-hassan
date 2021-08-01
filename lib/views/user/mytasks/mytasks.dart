import 'package:tasq/core/enum/taskstatus.dart';
import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/viewmodel/response_model.dart';
import 'package:tasq/core/viewmodel/task_model.dart';
import 'package:tasq/views/user/mytasks/local_widgets/myproposalitemview.dart';
import 'package:tasq/views/user/mytasks/local_widgets/mytaskitemview.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:tasq/views/widgets/rewardtabbar.dart';
import 'package:flutter/material.dart';

import '../../baseview.dart';

class MyUserTaskView extends StatefulWidget {
  MyUserTaskView({Key key}) : super(key: key);

  @override
  _MyUserTaskViewState createState() => _MyUserTaskViewState();
}

class _MyUserTaskViewState extends State<MyUserTaskView>
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
            leftTabTitle: 'applied',
            rightTabTitle: 'in progress',
            controller: _tabController,
          ),
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
                  child: BaseView<ResponseModel>(
                    onModelReady: (model) => model.fetchAppliedProposalList(),
                    builder: (_, model, __) => model.state == ViewState.Busy
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: model.appliedProposalList.length > 0
                                ? ListView.builder(
                                    itemCount: model.appliedProposalList.length,
                                    itemBuilder: (_, index) => MyTaskItemView(
                                      taskApplication:
                                          model.appliedProposalList[index],
                                    ),
                                  )
                                : Center(child: Text('Empty')),
                          ),
                  ),
                ),
                //second apge (in progress)
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: BaseView<TaskModel>(
                    onModelReady: (model) =>
                        model.fetchUserTaskList(taskstatus: TaskStatus.ALLOTED),
                    builder: (_, model, __) => model.state == ViewState.Busy
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: model.tasksList.length > 0
                                ? ListView.builder(
                                    itemCount: model.tasksList.length,
                                    itemBuilder: (_, index) =>
                                        MyProposalItemView(
                                      task: model.tasksList[index],
                                      onTaskCompleted: () {
                                        model.removeTaskFromList(
                                            model.tasksList[index]);
                                      },
                                    ),
                                  )
                                : Center(child: Text('Empty')),
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
