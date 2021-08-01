import 'package:tasq/core/model/user.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/utils/naviation_services.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:tasq/views/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class DateOfBirthPage extends StatefulWidget {
  DateOfBirthPage({Key key}) : super(key: key);

  @override
  _DateOfBirthPageState createState() => _DateOfBirthPageState();
}

class _DateOfBirthPageState extends State<DateOfBirthPage> {
  DateTime selectedDate;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //space from top
            SizedBox(height: 90.0),
            //dob heading text
            Text(
              Strings.enterdobtext,
              style: Theme.of(context).textTheme.headline2,
            ),
            //space from top
            SizedBox(height: 30.0),
            //date picker
            datePickerWidget(),
            //space from top
            SizedBox(height: 50.0),
            //next button
            nextButton(),
          ],
        ),
      ),
    );
  }

  datePickerWidget() {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
              child: Text(
                selectedDate == null
                    ? Strings.dobhint
                    : Jiffy(selectedDate, "dd, MMM yyyy").yMMMMd,
                style: TextStyle(fontSize: 17.0),
              ),
            ),
          ),
        ),
        SizedBox(width: 15.0),
        GestureDetector(onTap: () => pickDate(), child: Icon(Icons.date_range)),
      ],
    );
  }

  nextButton() {
    return Center(
      child: CustomButton(
        text: 'next',
        borderRadiusValue: 23.0,
        borderColor: MyColors.primaryColor,
        borderWidth: 3.0,
        textColor: Colors.black,
        fontWeight: FontWeight.bold,
        width: MediaQuery.of(context).size.width / 2.2,
        height: 45,
        fontSize: 19.0,
        onTap: () {
          if (selectedDate != null) {
            locator<MyAppUser>().dob = selectedDate;
            locator<NavigationService>().navigateTo(SelectOrginzationPageRoute);
          } else
            Utils.showSnackbar(
                scaffoldKey: scaffoldKey, message: Strings.pleaseSelectDOB);
        },
      ),
    );
  }

  pickDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate != null ? selectedDate : DateTime.now(),
      firstDate: DateTime(1960, 8),
      lastDate: DateTime(2022),
    );

    selectedDate = picked;
    setState(() {});
  }
}
