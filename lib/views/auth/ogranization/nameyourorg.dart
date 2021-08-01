import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/utils/naviation_services.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:tasq/views/widgets/custombutton.dart';
import 'package:flutter/material.dart';

class NameYouOrganizationPage extends StatefulWidget {
  NameYouOrganizationPage({Key key}) : super(key: key);

  @override
  _NameYouOrganizationPageState createState() =>
      _NameYouOrganizationPageState();
}

class _NameYouOrganizationPageState extends State<NameYouOrganizationPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final organizationNameController = TextEditingController();
  @override
  void dispose() {
    organizationNameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyAppUser user = locator<MyAppUser>();
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //space from top
              SizedBox(height: 40.0),
              Text(
                Strings.almostthere + '\n${user.name} !',
                style: Theme.of(context).textTheme.headline1,
              ),
              //space
              SizedBox(height: 40.0),
              Text(
                Strings.nameyourorg,
                style: Theme.of(context).textTheme.headline2,
              ),
              //textfield
              TextFormField(
                controller: organizationNameController,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
              //textfield underline
              Container(
                width: double.infinity,
                height: 3.0,
                decoration: BoxDecoration(gradient: MyColors.lineGradient),
              ),
              //space
              SizedBox(height: 120),
              nextButton(),
            ],
          ),
        ),
      ),
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
            if (organizationNameController.text.trim().isNotEmpty) {
              final organization = locator<Organization>();
              organization.orgName = organizationNameController.text.trim();
              locator<NavigationService>()
                  .navigateTo(OrganizationLogoPickerPageRoute);
            } else
              Utils.showSnackbar(
                  scaffoldKey: scaffoldKey, message: 'Name your organization');
          }),
    );
  }
}
