import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/services/auth_service.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/utils/constants/appdata.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:flutter/material.dart';

class EditDetailPage extends StatefulWidget {
  EditDetailPage({Key key}) : super(key: key);

  @override
  _EditDetailPageState createState() => _EditDetailPageState();
}

class _EditDetailPageState extends State<EditDetailPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final namefocusNode = FocusNode();
  final emailfocusNode = FocusNode();
  final passfocusNode = FocusNode();
  //appuser
  MyAppUser user = locator<MyAppUser>();
  //updatable
  bool isUpdatable = false;

  @override
  void initState() {
    nameController.text = user.isAdmin ? user.orgName : user.name;
    emailController.text = user.email;
    passController.text = '********';
    super.initState();
  }

  @override
  void dispose() {
    nameController?.dispose();
    emailController?.dispose();
    namefocusNode?.dispose();
    emailfocusNode?.dispose();
    passfocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: AppData.globalScaffoldKey,
      appBar: MyAppBar(
        title: 'edit details',
        trailingIcon: isUpdatable
            ? IconButton(
                onPressed: () => updateRecord(),
                icon: Icon(
                  Icons.check,
                  color: Colors.black,
                ),
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            //info card view
            Card(
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  //name
                  EditableRow(
                    controller: nameController,
                    iconData: Icons.account_circle,
                    focusNode: namefocusNode,
                    onChanged: (value) {
                      print(value);
                      print(nameController.text);
                      if (value != (user.isAdmin ? user.orgName : user.name)) {
                        print('true');
                        isUpdatable = true;
                      } else {
                        print('false');

                        isUpdatable = false;
                      }

                      setState(() {});
                    },
                  ),
                  //space
                  SizedBox(height: 15.0),
                  //email
                  EditableRow(
                    controller: emailController,
                    iconData: Icons.email,
                    focusNode: emailfocusNode,
                    readOnly: true,
                  ),
                  //password
                  EditableRow(
                    controller: passController,
                    iconData: Icons.lock,
                    focusNode: passfocusNode,
                    readOnly: true,
                  ),
                  //space
                  SizedBox(height: 10.0),
                ],
              ),
            ),
            //space
            SizedBox(height: 20.0),
            //password box
            GestureDetector(
              onTap: () {
                AuthService service = FirebaseAuthService();
                service.sendResetPasswordEmail(user.email);
                Utils.showSnackbar(
                    scaffoldKey: AppData.globalScaffoldKey,
                    message:
                        'Reset password link is successfully send your email');
              },
              child: Container(
                padding: EdgeInsets.all(18.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.black,
                ),
                child: Text(
                  'reset password',
                  style: MyTextStyle.heading15NormalWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateRecord() {
    FirestoreService fS = FirebaseFirestoreService();
    if (user.isAdmin) {
      Organization org = locator<Organization>();
      org.orgName = nameController.text;
      user.orgName = nameController.text;
      fS.updateUserRecord(user);
      fS.updateOrgRecord(org);
    } else {
      user.name = nameController.text;
      fS.updateUserRecord(user);
    }
    //show snackbar
    Utils.showSnackbar(
        scaffoldKey: AppData.globalScaffoldKey,
        message: 'Record sucessfully updated');

    setState(() {
      isUpdatable = false;
      namefocusNode.unfocus();
    });
  }
}

class EditableRow extends StatelessWidget {
  final IconData iconData;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool readOnly;
  final Function(String) onChanged;
  const EditableRow(
      {@required this.iconData,
      @required this.controller,
      this.focusNode,
      this.readOnly: false,
      this.onChanged,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, size: 30),
          SizedBox(width: 20.0),
          Flexible(
            child: EditableText(
              controller: controller,
              focusNode: focusNode,
              readOnly: readOnly,
              style: Theme.of(context).textTheme.headline4,
              cursorColor: Colors.black,
              backgroundCursorColor: Colors.black,
              onChanged: onChanged,
            ),
          )
        ],
      ),
    );
  }
}
