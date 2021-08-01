import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrgMember {
  String orgid;
  String orgname;
  String useruid;
  String username;
  int requeststatus;
  String role;
  String profileurl;
  DateTime requestAt;
  DocumentReference reference;

  OrgMember({
    this.orgname,
    this.orgid,
    this.useruid,
    this.username,
    this.requeststatus,
    this.role,
    this.profileurl,
    this.requestAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'orgid': orgid,
      'orgname': orgname,
      'useruid': useruid,
      'username': username,
      'requeststatus': requeststatus,
      'role': role,
      'profileurl': profileurl,
      'requestAt': DateTime.now(),
    };
  }

  OrgMember.fromMap(Map<String, dynamic> map, {this.reference})
      : orgid = map['orgid'],
        orgname = map['orgname'],
        useruid = map['useruid'],
        username = map['username'],
        requeststatus = map['requeststatus'],
        role = map['role'],
        profileurl = map['profileurl'],
        requestAt = map['companyuid'];

  OrgMember.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
