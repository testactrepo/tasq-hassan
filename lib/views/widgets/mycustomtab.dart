import 'package:tasq/utils/constants/mycolors.dart';
import 'package:flutter/material.dart';

class MyCustomTabBar extends StatelessWidget {
  final TabController controller;

  const MyCustomTabBar({@required this.controller, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: MyColors.tabBGColor,
        ),
        child: Center(
          child: TabBar(
            // isScrollable: true,
            controller: controller,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            indicatorPadding: EdgeInsets.all(3.0),
            tabs: [
              Tab(
                child: tabBoxWidget(
                    title: 'login', isSelected: controller.index == 0),
              ),
              Tab(
                child: tabBoxWidget(
                    title: 'signup', isSelected: controller.index == 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  tabBoxWidget({@required String title, bool isSelected}) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black : Colors.white),
      ),
    );
  }
}
