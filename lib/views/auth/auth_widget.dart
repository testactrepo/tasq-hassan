import 'package:tasq/core/enum/usertype.dart';
import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/core/viewmodel/auth_model.dart';
import 'package:tasq/utils/constants/appdata.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'login_signup_pages.dart';

// class AuthWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authModel = Provider.of<AuthModel>(context, listen: false);
//     return FutureBuilder<bool>(
//       future: authModel.isUserLoggedIn(),
//       builder: (context, snapshot) {
//         final bool isLoggedIn = snapshot.data;
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           print('waiting screen');
//           return WaitingScreen();
//         } else {
//           print('Active');
//           if (isLoggedIn) {
//             print('user not null');
//             SchedulerBinding.instance.addPostFrameCallback((_) {
//               Methods.navigateAndReplacePageRoute(route: BottomNavBarRoute);
//             });
//             return WaitingScreen();
//           } else {
//             return LoginSignupPages();
//           }
//         }
//       },
//     );
//   }
// }

// class WaitingScreen extends StatelessWidget {
//   const WaitingScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context, listen: false);
    return FutureBuilder<User>(
      future: authModel.isUserLoggedIn(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return WaitingScreen();
        } else {
          if (user != null) {
            FirestoreService firestoreService = FirebaseFirestoreService();

            return FutureBuilder<Object>(
              future: firestoreService.loadMyAppUserData(user.uid),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return WaitingScreen();
                } else {
                  if (AppData.userType == UserType.USER) {
                    locator<MyAppUser>().update(snapshot.data);
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Utils.navigateAndReplacePageRoute(
                          route: UserBottomNavBarRoute);
                    });
                  } else {
                    locator<Organization>().update(snapshot.data);
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Utils.navigateAndReplacePageRoute(
                          route: AdminBottomNavBarRoute);
                    });
                  }

                  return WaitingScreen();
                }
              },
            );

            // print('user not null');

          } else {
            return LoginSignupPages();
          }
        }
      },
    );
  }
}

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
