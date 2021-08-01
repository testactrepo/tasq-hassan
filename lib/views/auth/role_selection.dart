import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/viewmodel/auth_model.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/utils/naviation_services.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:tasq/views/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'local_widgets/gradientcontainer.dart';

class RoleSelectionView extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  RoleSelectionView(
      {@required this.name, @required this.email, @required this.password});

  @override
  _RoleSelectionViewState createState() => _RoleSelectionViewState();
}

class _RoleSelectionViewState extends State<RoleSelectionView> {
  final nameController = TextEditingController();
  FocusNode focusnode;

  @override
  void initState() {
    nameController.text = widget.name;
    focusnode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    nameController?.dispose();
    focusnode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //space from top
            SizedBox(height: 40.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey,",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      EditableText(
                        controller: nameController,
                        focusNode: focusnode,
                        readOnly: !focusnode.hasFocus,
                        style: Theme.of(context).textTheme.headline2,
                        cursorColor: Colors.black,
                        backgroundCursorColor: Colors.black,
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(focusnode.hasFocus ? Icons.check : Icons.edit),
                  onPressed: () {
                    if (focusnode.hasFocus)
                      focusnode.unfocus();
                    else
                      focusnode.requestFocus();
                    print('hasFocus: ' + focusnode.hasFocus.toString());
                    setState(() {});
                  },
                ),
              ],
            ),
            //space
            SizedBox(height: 40.0),

            Center(
              child: CustomButton(
                text: "register as a",
                width: 190.0,
                padding: const EdgeInsets.all(10.0),
                borderColor: Colors.grey,
                borderRadiusValue: 30.0,
                textColor: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 19.0,
                onTap: null,
              ),
            ),
            //space
            SizedBox(height: 40.0),
            GradientContainer(
              text: Strings.user,
              onTap: () async {
                MyAppUser user = locator<MyAppUser>();
                user.name = nameController.text;
                user.email = widget.email;
                AuthModel authModel = context.read<AuthModel>();
                user = await authModel.signUpWithEmailPassword(
                    user, widget.password);
                //signup and move to next screen (Dateofbirth screen)
                if (authModel.state == ViewState.Idle)
                  Utils.navigateTo(DateOfBirthPageRoute);
              },
            ),
            //space
            SizedBox(height: 40.0),
            GradientContainer(
              text: Strings.organization,
              gradient: MyColors.greenGradient,
              onTap: () async {
                MyAppUser user = locator<MyAppUser>();
                user.name = nameController.text;
                user.email = widget.email;
                Organization org = locator<Organization>();
                org.email = widget.email;

                AuthModel authModel = context.read<AuthModel>();
                user = await authModel.signUpWithEmailPassword(
                    user, widget.password,
                    organization: org);

                //signup and move to next screen (Dateofbirth screen)
                if (authModel.state == ViewState.Idle)
                  Utils.navigateTo(NameYourOrgPageRoute);
              },
            ),
          ],
        ),
      ),
    );
  }

  navigateToNameYourOrgPage() {
    locator<NavigationService>().navigateTo(NameYourOrgPageRoute);
  }
}
