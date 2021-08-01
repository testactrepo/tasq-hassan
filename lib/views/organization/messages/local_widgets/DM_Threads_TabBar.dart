import 'package:tasq/utils/constants/mycolors.dart';
import 'package:flutter/material.dart';

class DMThreadsTabBar extends StatelessWidget {
  final TabController controller;

  const DMThreadsTabBar({@required this.controller, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 3.0,
        color: MyColors.messagescreenTabBarBGColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: TabBar(
            controller: controller,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            indicatorPadding: EdgeInsets.all(6.0),
            tabs: [
              Tab(
                child: tabBoxWidget(title: 'DMs'),
              ),
              Tab(
                child: tabBoxWidget(title: 'Threads'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  tabBoxWidget({@required String title}) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    );
  }
}
