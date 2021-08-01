import 'package:tasq/core/model/task.dart';
import 'package:tasq/views/organization/mytask/taskdetail_response/responsepageview.dart';
import 'package:tasq/views/widgets/activity_post.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:tasq/views/widgets/rewardtabbar.dart';
import 'package:flutter/material.dart';

class TaskDetailAndResponse extends StatefulWidget {
  final Task task;
  const TaskDetailAndResponse({@required this.task, Key key}) : super(key: key);

  @override
  _TaskDetailAndResponseState createState() => _TaskDetailAndResponseState();
}

class _TaskDetailAndResponseState extends State<TaskDetailAndResponse>
    with SingleTickerProviderStateMixin {
  //pageview init start
  PageController _pageController;
  //tab controller
  TabController _tabController;
  //scaffoldkey
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: scaffoldKey,
      appBar: MyAppBar(title: 'my posting'),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            MyTabBar(
              leftTabTitle: 'my post',
              rightTabTitle: 'responses',
              controller: _tabController,
            ),
            //space from top
            SizedBox(height: 15.0),
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
                    child: PostDetail(taskData: widget.task),
                  ),
                  //second apge (recurring)
                  ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: ResponsePageView(
                      taskuid: widget.task.reference.id,
                      scaffoldKey: scaffoldKey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void animateToPage({@required index}) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
