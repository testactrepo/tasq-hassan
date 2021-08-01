import 'package:tasq/core/model/chatroom.dart';
import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/services/firestorestreamservice.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/views/organization/messages/threadview.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:provider/provider.dart';
import 'dmspageview.dart';
import 'local_widgets/DM_Threads_TabBar.dart';

class MessagesPageView extends StatefulWidget {
  MessagesPageView({Key key}) : super(key: key);

  @override
  _MessagesPageViewState createState() => _MessagesPageViewState();
}

class _MessagesPageViewState extends State<MessagesPageView>
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
    MyAppUser user = locator<MyAppUser>();
    // Organization org = locator<Organization>();
    // print(org.uid);
    return StreamProvider<List<ChatRoom>>.value(
      initialData: [],
      value: FirestoreStreamService()
          .chatroomListStream(user.isAdmin ? user.orgId : user.uid),
      child: Scaffold(
        appBar: MyAppBar(title: 'messages'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              DMThreadsTabBar(controller: _tabController),
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
                      child: DMsPageView(),
                    ),
                    //second apge (recurring)
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: ThreadView(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void animateToPage({@required index}) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
