import 'dart:io';
import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/services/auth_service.dart';
import 'package:tasq/core/services/firebase_storage_service.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/utils/constants/firebasepath.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'base_model.dart';

class AuthModel extends BaseModel {
  final AuthService _authService = FirebaseAuthService();
  String errorMessage;

  Stream<User> get authStateChanges {
    return _authService.authStateChanges;
  }

  Future<User> isUserLoggedIn() async {
    return await _authService.getCurrentUser();
  }

  Future<MyAppUser> signUpWithEmailPassword(
      MyAppUser myAppUser, String password,
      {Organization organization}) async {
    setState(ViewState.Busy);

    MyAppUser user = await _authService.signUpWithEmailPassword(
        myAppUser: myAppUser, organization: organization, password: password);

    setState(ViewState.Idle);
    return user;
  }

  Future<MyAppUser> signInWithEmailPassword(
      String email, String password) async {
    setState(ViewState.Busy);

    User user = await _authService.signInWithEmailPassword(
        email: email, password: password);

    MyAppUser myAppUser;

    if (user == null) {
      errorMessage = Strings.emailORpasswordIncorrect;
      setState(ViewState.Idle);
      return myAppUser;
    } else {
      FirestoreService service = FirebaseFirestoreService();
      //load user data
      myAppUser = await service.loadMyAppUserData(user.uid);
    }

    setState(ViewState.Idle);
    return myAppUser;
  }

  Future<void> signOut() => _authService.signOut();

  Future<void> updateOrganizationData(
      File file, firebasepath, Organization organization) async {
    setState(ViewState.Busy);
    StorageService storageService = FirebaseStorageService();
    String downloadUrl = await storageService.uploadProfilePicture(file,
        firebasePath: firebasepath);
    organization.profileUrl = downloadUrl;
    await FirebasePath.organization(organization.uid)
        .update(organization.toMap());
    //also update the createdbyuid
    MyAppUser user = locator<MyAppUser>();
    user.orgName = organization.orgName;
    await FirebasePath.users(organization.createdbyuid).update(user.toMap());
    setState(ViewState.Idle);
    return;
  }

  Future<void> updateUserData(File file, firebasepath, MyAppUser user) async {
    setState(ViewState.Busy);
    String downloadUrl;
    if (file != null) {
      StorageService storageService = FirebaseStorageService();
      downloadUrl = await storageService.uploadProfilePicture(file,
          firebasePath: firebasepath);
    }
    user.profileUrl = downloadUrl;
    await FirebasePath.users(user.uid).update(user.toMap());
    setState(ViewState.Idle);
    return;
  }
}
