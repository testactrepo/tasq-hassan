import 'package:tasq/views/auth/user/dateofbirth_page.dart';
import 'package:tasq/views/auth/instructions.dart';
import 'package:tasq/views/auth/login_signup_pages.dart';
import 'package:tasq/views/auth/ogranization/nameyourorg.dart';
import 'package:tasq/views/auth/ogranization/organizationlogo_picker_page.dart';
import 'package:tasq/views/auth/role_selection.dart';
import 'package:tasq/views/auth/user/selectorganizationview.dart';
import 'package:tasq/views/auth/user/userprofilepickerscreen.dart';
import 'package:tasq/views/bottomnavbar/adminbottomnavbar.dart';
import 'package:tasq/views/bottomnavbar/userbottomnavbar.dart';
import 'package:tasq/views/organization/home/newactivity/local_widgets/assignfromview.dart';
import 'package:tasq/views/organization/home/newactivity/newactivityview.dart';
import 'package:tasq/views/organization/profile/manage_members/manage_members.dart';
import 'package:tasq/views/organization/profile/pending_requests/pending_request_view.dart';
import 'package:tasq/views/organization/rewards/addnewreward.dart';
import 'package:tasq/views/organization/rewards/rewardsview.dart';
import 'package:tasq/views/share/editdetail.dart';
import 'package:tasq/views/share/myaccountsview.dart';
import 'package:tasq/views/user/home/homeview.dart';
import 'package:flutter/material.dart';
import 'routing_names.dart';
import '../extensions/string_extension.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData;

  switch (routingData.route) {
    case Signin_Signup_Route:
      return _getPageRoute(LoginSignupPages(), settings);
    case DateOfBirthPageRoute:
      return _getPageRoute(DateOfBirthPage(), settings);
    case RoleSelectionPageRoute:
      List<String> list = settings.arguments;

      return _getPageRoute(
          RoleSelectionView(name: list[0], email: list[1], password: list[2]),
          settings);
    case NameYourOrgPageRoute:
      return _getPageRoute(NameYouOrganizationPage(), settings);
    case OrganizationLogoPickerPageRoute:
      return _getPageRoute(OrganizationLogoPickerPage(), settings);
    case InstructionsPageRoute:
      return _getPageRoute(InstructionsPage(), settings);
    case UserHomePageRoute:
      return _getPageRoute(UserHomeView(), settings);
    case UserBottomNavBarRoute:
      return _getPageRoute(UserBottomNavBarView(), settings);
    case AdminBottomNavBarRoute:
      return _getPageRoute(AdminBottomNavBarView(), settings);
    case SelectOrginzationPageRoute:
      return _getPageRoute(SelectOrganizationUserView(), settings);
    case UserAddProfilePageRoute:
      return _getPageRoute(UserAddProfileScreen(), settings);
    case NewActivityPageRoute:
      final list = settings.arguments;
      return _getPageRoute(NewActivityView(rewardList: list), settings);
    case AdminRewardPageRoute:
      return _getPageRoute(AdminRewardsView(), settings);
    case AddNewRewardPageRoute:
      return _getPageRoute(AddNewRewardView(), settings);
    case AssignFromTeamPageRoute:
      return _getPageRoute(AssignFromView(), settings);
    case PendingRequestsPageRoute:
      return _getPageRoute(PendingRequestView(), settings);
    case ManageMembersPageRoute:
      return _getPageRoute(ManageMembersView(), settings);
    case MyAccountsPageRoute:
      return _getPageRoute(MyAccountsView(), settings);
    case EditDetailPageRoute:
      return _getPageRoute(EditDetailPage(), settings);
    default:
      return _getPageRoute(LoginSignupPages(), settings);
  }
}

navigateToPageWithReplacement(Widget child, settings) {
  return MaterialPageRoute(builder: (context) => child, settings: settings);
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({
    this.child,
    this.routeName,
  }) : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
