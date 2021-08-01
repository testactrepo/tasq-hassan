import 'package:tasq/core/enum/usertype.dart';
import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/core/services/formvalidation_service.dart';
import 'package:tasq/core/viewmodel/auth_model.dart';
import 'package:tasq/main.dart';
import 'package:tasq/utils/constants/appdata.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/mycustomtab.dart';
import 'local_widgets/signinbody.dart';
import 'local_widgets/signupbody.dart';
import 'local_widgets/topstaticbackgroud.dart';

class LoginSignupPages extends StatefulWidget {
  LoginSignupPages({Key key}) : super(key: key);

  @override
  _LoginSignupPagesState createState() => _LoginSignupPagesState();
}

class _LoginSignupPagesState extends State<LoginSignupPages>
    with SingleTickerProviderStateMixin {
  //form key
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  //text fields
  TextEditingController lemailTextController = TextEditingController();
  TextEditingController lpasswordTextController = TextEditingController();
  TextEditingController snameTextController = TextEditingController();
  TextEditingController semailTextController = TextEditingController();
  TextEditingController spasswordTextController = TextEditingController();
  TextEditingController sconfirmpasswordTextController =
      TextEditingController();
  //obscureText
  bool obscureText = true;
  PageController _pageController;
  //tab controller
  TabController _tabController;
  //auth model
  AuthModel authModel;

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(0);
    _tabController.addListener(() {
      animateToPage(index: _tabController.index);
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _tabController?.dispose();
    lpasswordTextController?.dispose();
    lemailTextController?.dispose();
    snameTextController?.dispose();
    semailTextController?.dispose();
    spasswordTextController?.dispose();
    sconfirmpasswordTextController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authModel = Provider.of<AuthModel>(context, listen: false);
    return Scaffold(
      key: AppData.globalScaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            //space
            // SizedBox(height: 60.0),
            //top flame image and box with t design
            TopStaticDesign(),
            MyCustomTabBar(controller: _tabController),
            //pages
            Expanded(
              flex: 2,
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) {
                  _tabController.animateTo(i);
                  setState(() {});
                },
                children: <Widget>[
                  //first page (profile)
                  ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: Form(
                      key: _formKey1,
                      child: SigninBody(
                        emailTextController: lemailTextController,
                        passTextController: lpasswordTextController,
                        obscureText: obscureText,
                        obscureSuffixTap: () {
                          obscureText = !obscureText;
                          setState(() {});
                        },
                        onSigninTap: () async {
                          bool result = loginValidation();
                          if (result) {
                            final user =
                                await authModel.signInWithEmailPassword(
                              lemailTextController.text.trim(),
                              lpasswordTextController.text.trim(),
                            );

                            if (user != null) {
                              Utils.navigateAndReplacePageRoute(
                                route: user.isAdmin
                                    ? AdminBottomNavBarRoute
                                    : UserBottomNavBarRoute,
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  //second apge (recurring)
                  ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: Form(
                      key: _formKey2,
                      child: SignupBody(
                        nameTextController: snameTextController,
                        emailTextController: semailTextController,
                        passTextController: spasswordTextController,
                        confirmTextController: sconfirmpasswordTextController,
                        onSingupTap: () {
                          if (signupValidation()) {
                            Utils.navigateTo(
                              RoleSelectionPageRoute,
                              arguments: [
                                snameTextController.text.trim(),
                                semailTextController.text.trim(),
                                spasswordTextController.text.trim(),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void animateToPage({@required index}) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  bool loginValidation() {
    if (FormValidationService.validateEmail(lemailTextController.text) &&
        FormValidationService.validatePassword(lpasswordTextController.text)) {
      Utils.showSnackbar(
          scaffoldKey: AppData.globalScaffoldKey,
          message: 'Password or Email is incorrect');
      return false;
    } else if (FormValidationService.validateEmail(lemailTextController.text)) {
      Utils.showSnackbar(
          scaffoldKey: AppData.globalScaffoldKey,
          message: 'Please enter valid email');
      return false;
    } else if (FormValidationService.validatePassword(
        lpasswordTextController.text)) {
      Utils.showSnackbar(
          scaffoldKey: AppData.globalScaffoldKey,
          message: 'Please enter correct password');
      return false;
    } else {
      return true;
    }
  }

  bool signupValidation() {
    if (FormValidationService.validateEmail(semailTextController.text) &&
        FormValidationService.validatePassword(spasswordTextController.text) &&
        FormValidationService.validateName(snameTextController.text)) {
      Utils.showSnackbar(
          scaffoldKey: AppData.globalScaffoldKey,
          message: 'Password or Email is incorrect');
      return false;
    } else if (FormValidationService.validateName(snameTextController.text)) {
      Utils.showSnackbar(
          scaffoldKey: AppData.globalScaffoldKey,
          message: 'Name field should not be empty');
      return false;
    } else if (FormValidationService.validateEmail(semailTextController.text)) {
      Utils.showSnackbar(
          scaffoldKey: AppData.globalScaffoldKey,
          message: 'Please enter valid email');
      return false;
    } else if (FormValidationService.validatePassword(
        spasswordTextController.text)) {
      Utils.showSnackbar(
          scaffoldKey: AppData.globalScaffoldKey,
          message: 'Password should be 6+ characters');
      return false;
    } else if (FormValidationService.validatePassword(
        sconfirmpasswordTextController.text)) {
      Utils.showSnackbar(
          scaffoldKey: AppData.globalScaffoldKey,
          message: 'Confirm password is incorrect');
      return false;
    } else {
      return true;
    }
  }
}
