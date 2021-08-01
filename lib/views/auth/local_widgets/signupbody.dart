import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/services/formvalidation_service.dart';
import 'package:tasq/core/viewmodel/auth_model.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/views/widgets/custombutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

class SignupBody extends StatelessWidget {
  final TextEditingController nameTextController;
  final TextEditingController emailTextController;
  final TextEditingController passTextController;
  final TextEditingController confirmTextController;
  final VoidCallback onSingupTap;
  const SignupBody({
    @required this.nameTextController,
    @required this.emailTextController,
    @required this.passTextController,
    @required this.confirmTextController,
    @required this.onSingupTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 23.0),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //email field
                        nameField(),
                        emailField(),
                        //password field
                        passwordField(),
                        confirmPasswordField(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 390.0),
                signupButton(context),
              ],
            ),
            //circular Progree indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Center(
                child: Consumer<AuthModel>(builder: (_, model, __) {
                  if (model.state == ViewState.Busy)
                    return CircularProgressIndicator();
                  else
                    return Container(width: 0, height: 0);
                }),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  nameField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextFormField(
        // focusNode: myFocusNodeEmailLogin,
        controller: nameTextController,
        // validator: (value) {
        //   if (value.isEmpty) return "This field can't be empty";
        //   return null;
        // },
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(FontAwesome5.user_circle, color: Colors.black, size: 28.0),
          hintText: "name",
          hintStyle: TextStyle(fontSize: 17.0),
        ),
      ),
    );
  }

  emailField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 28.0),
      child: TextFormField(
        // focusNode: myFocusNodeEmailLogin,
        controller: emailTextController,
        // validator: (value) => FormValidationService.validateEmail(value),
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.email, color: Colors.black, size: 28.0),
          hintText: "e-mail",
          hintStyle: TextStyle(fontSize: 17.0),
        ),
      ),
    );
  }

  passwordField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextFormField(
        // focusNode: myFocusNodePasswordLogin,
        controller: passTextController,
        obscureText: true,
        // validator: (value) => FormValidationService.validatePassword(value),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.lock, size: 28.0, color: Colors.black),
          hintText: "Password",
          hintStyle: TextStyle(fontSize: 17.0),
          suffixIcon:
              Icon(Icons.remove_red_eye, size: 15.0, color: Colors.black),
        ),
      ),
    );
  }

  confirmPasswordField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextFormField(
        // focusNode: myFocusNodePasswordLogin,
        controller: confirmTextController,
        obscureText: true,
        // validator: (value) => FormValidationService.confirmPasswordValidation(
        //     passTextController.text.trim(), confirmTextController.text.trim()),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.lock, size: 28.0, color: Colors.black),
          hintText: "confirmation",
          hintStyle: TextStyle(fontSize: 17.0),
          suffixIcon:
              Icon(Icons.remove_red_eye, size: 15.0, color: Colors.black),
        ),
      ),
    );
  }

  signupButton(context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: onSingupTap,
        child: Transform.translate(
          offset: Offset(0, 0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CustomButton(
              text: Strings.signup,
              disableBorder: true,
              borderRadiusValue: 4.0,
              gradient: MyColors.primaryGradient,
              width: MediaQuery.of(context).size.width / 1.6,
              height: 60,
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
              onTap: null,
            ),
          ),
        ),
      ),
    );
  }
}
