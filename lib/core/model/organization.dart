import 'package:cloud_firestore/cloud_firestore.dart';

class Organization {
  String uid;
  String createdbyuid;
  String email;
  String orgName;
  String profileUrl;
  String dateofbirth;
  bool isOrg;
  String org_gstin;
  String phone;
  int completedtasks;
  int totalcreatedtasks;
  int totalunreadmsgs;
  int numofpendingrequests;
  DateTime createdAt;
  DocumentReference reference;
  List<String> socials;

  Organization({
    this.uid,
    this.email,
    this.createdbyuid,
    this.orgName,
    this.isOrg,
    this.profileUrl,
    this.totalcreatedtasks,
    this.totalunreadmsgs,
    this.completedtasks,
    this.numofpendingrequests,
    this.createdAt,
    this.socials,
  });

  update(Organization organization) {
    this.uid = organization.uid;
    this.createdbyuid = organization.createdbyuid;
    this.email = organization.email;
    this.orgName = organization.orgName;
    this.profileUrl = organization.profileUrl;
    this.totalcreatedtasks = organization.totalcreatedtasks;
    this.completedtasks = organization.completedtasks;
    this.totalunreadmsgs = organization.totalunreadmsgs;
    this.numofpendingrequests = organization.numofpendingrequests;
    this.createdAt = organization.createdAt;
    this.socials = organization.socials;
  }

  Map<String, dynamic> toMap() {
    return {
      'createdbyuid': createdbyuid,
      'email': email,
      'orgName': orgName,
      'totalcreatedtasks': totalcreatedtasks,
      'completedtasks': completedtasks,
      'totalunreadmsgs': totalunreadmsgs,
      'orglogo': profileUrl,
      'pendingrequests': numofpendingrequests,
      'dateofbirth': null,
      'isOrg': true,
      'org_gstin': '124833637367254',
      'phone': null,
      'createdAt': DateTime.now(),
      'socials': null,
    };
  }

  Organization.fromMap(Map<String, dynamic> map, this.uid, {this.reference})
      : createdbyuid = map['adminname'],
        email = map['email'],
        orgName = map['orgName'],
        totalcreatedtasks =
            map['totalcreatedtasks'] != null ? map['totalcreatedtasks'] : 0,
        completedtasks =
            map['completedtasks'] != null ? map['completedtasks'] : 0,
        totalunreadmsgs =
            map['totalunreadmsgs'] != null ? map['totalunreadmsgs'] : 0,
        numofpendingrequests =
            map['pendingrequests'] != null ? map['pendingrequests'] : 0,
        profileUrl = map['orglogo'],
        createdAt = map['createdAt'].toDate();

  Organization.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), snapshot.reference.id,
            reference: snapshot.reference);
}
