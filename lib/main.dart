import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/naviation_services.dart';
import 'package:tasq/utils/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/viewmodel/auth_model.dart';
import 'core/viewmodel/myrewards_model.dart';
import 'views/auth/login_signup_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthModel()),
        ChangeNotifierProvider(create: (_) => MyRewardsModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'tasQ',
        theme: ThemeData( fontFamily: 'Montserrat',
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontFamily: Strings.primaryFontName,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Colors.black,
            ),
            headline2: TextStyle(
              fontFamily: Strings.primaryFontName,
              fontWeight: FontWeight.w500,
              fontSize: 30.0,
              color: Colors.black,
            ),
            headline3: TextStyle(
              fontFamily: Strings.primaryFontName,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Colors.black,
            ),
            headline4: TextStyle(
              fontFamily: Strings.primaryFontName,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black,
            ),
            headline6: TextStyle(
              fontFamily: Strings.primaryFontName,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
        ),
        home: LoginSignupPages(),
        // home: AuthWidget(),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
