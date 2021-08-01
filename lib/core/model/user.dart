import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MyAppUser {
  String uid;
  String name;
  DateTime dob;
  bool isAdmin;
  String orgId;
  String orgName;
  String email;
  String profileUrl;
  List<dynamic> rewardsList;
  int points;
  int completedtasks;
  int allassignedtasks;
  DateTime createdAt;
  DocumentReference reference;
  Map<String, dynamic> socials;
  bool isActive;
  String userId;

  MyAppUser({
    this.uid,
    this.name,
    this.email,
    this.dob,
    this.isAdmin,
    this.orgId,
    this.orgName,
    this.points,
    this.completedtasks,
    this.allassignedtasks,
    this.profileUrl,
    this.rewardsList,
    this.createdAt,
    this.socials,
    this.isActive,
    this.userId,
  });

  update(MyAppUser user) {
    this.uid = user.uid;
    this.name = user.name;
    this.email = user.email;
    this.dob = user.dob;
    this.isAdmin = user.isAdmin;
    this.orgId = user.orgId;
    this.orgName = user.orgName;
    this.points = user.points;
    this.allassignedtasks = user.allassignedtasks;
    this.completedtasks = user.completedtasks;
    this.profileUrl = user.profileUrl;
    this.rewardsList = user.rewardsList;
    this.createdAt = user.createdAt;
    this.socials = user.socials;
    this.isActive = user.isActive;
    this.userId = user.userId;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'dob': dob,
      'isAdmin': isAdmin,
      'phone': null,
      'isOrg': false,
      'orgId': orgId,
      'orgName': orgName,
      'points': points,
      'completedtasks': completedtasks,
      'allassignedtasks': allassignedtasks,
      'profileUrl': profileUrl,
      'rewardsList': rewardsList,
      'createdAt': DateTime.now(),
      'socials': {"lnkd":'', "fb":'', "web":''},
      'isActive': true,
      'userId': uid,
    };
  }

  MyAppUser.fromMap(Map<String, dynamic> map, this.uid, {this.reference})
      : name = map['name'],
        email = map['email'],
        dob = map['dob'] != null ? map['dob'].toDate() : null,
        isAdmin = map['isAdmin'],
        orgId = map['orgId'],
        orgName = map['orgName'],
        points = map['points'] == null ? 0 : map['points'],
        completedtasks =
            map['completedtasks'] == null ? 0 : map['completedtasks'],
        allassignedtasks =
            map['allassignedtasks'] == null ? 0 : map['allassignedtasks'],
        profileUrl = map['profileUrl'],
        rewardsList =
            map['rewardsList'] != null ? List.from(map['rewardsList']) : [],
        createdAt = map['createdAt'].toDate();

  MyAppUser.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), snapshot.reference.id,
            reference: snapshot.reference);
}
