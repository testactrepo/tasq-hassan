import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/orgmembers.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/utils/constants/firebasepath.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthService {
  Future<MyAppUser> signUpWithEmailPassword(
      {@required MyAppUser myAppUser,
      Organization organization,
      @required password});
  Future<User> signInWithEmailPassword({@required email, @required password});
  Future<User> getCurrentUser();
  Stream<User> get authStateChanges;
  Future<void> sendResetPasswordEmail(email);
  Future<void> signOut();
}

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  Future<User> signInWithEmailPassword({email, password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('User Exception: ' + e.toString());
      return null;
    }
  }

  @override
  Future<MyAppUser> signUpWithEmailPassword(
      {myAppUser, organization, password}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: myAppUser.email, password: password);
      //add record to user collection
      myAppUser.uid = userCredential.user.uid;
      myAppUser.isAdmin = false;

      if (organization != null) {
        organization.createdbyuid = userCredential.user.uid;
        organization.totalcreatedtasks = 0;
        organization.totalunreadmsgs = 0;
        organization.completedtasks = 0;
        String orguid = await createOrganiztionCollection(organization);
        organization.uid = orguid;
        myAppUser.orgId = orguid;
        myAppUser.isAdmin = true;
        myAppUser.orgId = orguid;
      }
      createUserCollection(myAppUser);
      //also add user to orgmembers collection
      OrgMember orgMembers = OrgMember();
      orgMembers.orgid = organization.uid;
      orgMembers.orgname = organization.orgName;
      orgMembers.useruid = myAppUser.uid;
      orgMembers.username = myAppUser.name;
      orgMembers.requeststatus = 1; //approved
      orgMembers.role = 'admin'; //admin or user
      createOrgMembersCollection(orgMembers);

      return myAppUser;
    } catch (e) {
      print('User Exception: ' + e.toString());
      return null;
    }
  }

  createUserCollection(MyAppUser myAppUser) async {
    await FirebasePath.users(myAppUser.uid).set(myAppUser.toMap());
  }

  Future<String> createOrganiztionCollection(Organization organization) async {
    DocumentReference ref =
        await FirebasePath.organizationCollection().add(organization.toMap());
    return ref.id;
  }

  createOrgMembersCollection(OrgMember orgMembers) async {
    await FirebasePath.orgMembersCollection().add(orgMembers.toMap());
  }

  @override
  Future<User> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<User> get authStateChanges {
    return _firebaseAuth.authStateChanges();
  }

  @override
  Future<void> sendResetPasswordEmail(email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
