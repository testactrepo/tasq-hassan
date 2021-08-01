import 'package:flutter/material.dart';

class CustomDropDownPopup extends StatelessWidget {
  final List<String> optionsList;
  final VoidCallback onOption1Tap;
  final VoidCallback onOption2Tap;
  const CustomDropDownPopup({
    this.optionsList: const ['allot this task', 'delete response'],
    @required this.onOption1Tap,
    this.onOption2Tap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => optionsList
          .map((option) => PopupMenuItem(
              value: optionsList.indexOf(option), child: Text(option)))
          .toList(),
      initialValue: 4,
      onCanceled: () {
        print("You have canceled the menu.");
      },
      onSelected: (value) {
        print(value.toString());
        if (value == 0)
          this.onOption1Tap();
        else if (value == 1) this.onOption2Tap();
      },
      icon: Icon(Icons.more_vert),
    );
  }
}
