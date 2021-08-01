import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/services/formvalidation_service.dart';
import 'package:tasq/core/viewmodel/auth_model.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/views/widgets/custombutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninBody extends StatelessWidget {
  final TextEditingController emailTextController;
  final TextEditingController passTextController;
  //if hide: user login else organization login
  final bool obscureText;
  final VoidCallback onSigninTap;
  final VoidCallback obscureSuffixTap;
  const SigninBody({
    @required this.emailTextController,
    @required this.passTextController,
    this.obscureText: true,
    this.obscureSuffixTap,
    @required this.onSigninTap,
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
                        emailField(),
                        passwordField(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 220.0),
                loginButton(context),
              ],
            ),
            //space
            SizedBox(height: 60.0),
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

            //forgot password
            TextButton(
              onPressed: () {},
              child: Text(
                Strings.forgotPassword,
                style: TextStyle(
                  color: MyColors.primaryColor,
                  fontFamily: Strings.primaryFontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  emailField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextFormField(
        // focusNode: myFocusNodeEmailLogin,
        controller: emailTextController,
        // validator: (value) => FormValidationService.validateEmail(value),
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.email,
            color: Colors.black,
            size: 22.0,
          ),
          hintText: "Email Address",
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
        obscureText: obscureText,
        // validator: (value) => FormValidationService.validatePassword(value),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.lock, size: 22.0, color: Colors.black),
          hintText: "Password",
          hintStyle: TextStyle(fontSize: 17.0),
          suffixIcon: GestureDetector(
            onTap: obscureSuffixTap,
            child: Icon(
              Icons.remove_red_eye,
              size: 15.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  loginButton(context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: onSigninTap,
        child: Transform.translate(
          offset: Offset(0, 0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CustomButton(
              text: Strings.login,
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
