import 'package:tasq/utils/constants/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final int maxLines;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final Function validator;
  MyTextField(
      {this.title,
      this.controller,
      this.inputFormatters,
      this.maxLines = 1,
      this.focusNode,
      this.validator,
      this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            "$title",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        TextFormField(
          maxLines: maxLines,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          // validator: validator,
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyColors.primaryColor)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyColors.primaryColor)),
          ),
        ),
      ],
    );
  }
}
