import 'package:tasq/utils/constants/mycolors.dart';
import 'package:flutter/material.dart';

class MyDropDownMenu extends StatelessWidget {
  final String title;
  final String hintText;
  final List<dynamic> list;
  final Function(dynamic) onChanged;
  const MyDropDownMenu({
    @required this.title,
    @required this.hintText,
    @required this.list,
    @required this.onChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            "$title",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          constraints: BoxConstraints(maxWidth: 250.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              hintText: "$hintText",
              hintStyle: Theme.of(context).textTheme.headline6,
              contentPadding: EdgeInsets.all(12),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.primaryColor)),
            ),
            items: List.generate(list?.length ?? 0, (index) {
              return DropdownMenuItem(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 250.0),
                  child: Text(
                    list[index] is String ? list[index] : list[index].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                value: list[index],
              );
            }),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
