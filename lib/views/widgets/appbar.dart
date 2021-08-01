import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final title;
  final trailingIcon;
  const MyAppBar({@required this.title, this.trailingIcon, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: BackButton(
        color: Colors.black,
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      actions: [
        trailingIcon == null
            ? Container(width: 0, height: 0)
            : Padding(
                padding: EdgeInsets.only(right: 15.0), child: trailingIcon),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}
