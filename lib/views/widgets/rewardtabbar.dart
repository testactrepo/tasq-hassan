import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  final String leftTabTitle;
  final String rightTabTitle;
  final TabController controller;

  const MyTabBar({
    this.leftTabTitle: 'my rewards',
    this.rightTabTitle: 'expore and add',
    @required this.controller,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      // isScrollable: true,
      controller: controller,
      indicatorColor: Colors.black,
      // indicatorPadding: EdgeInsets.all(3.0),
      tabs: [
        Tab(
          child: tabBoxWidget(title: leftTabTitle),
        ),
        Tab(
          child: tabBoxWidget(title: rightTabTitle),
        ),
      ],
    );
  }

  tabBoxWidget({@required String title}) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
