import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String taskname;
  String description;
  String orgname;
  String orgProfileUrl;
  String orguid;
  String selectedCategory;
  DateTime duein;
  String assignToUserUID;
  String rewardtitle;
  String rewarduid;
  int pointsOffered;
  int numberofresponses;
  String status;
  DateTime createdAt;
  DocumentReference reference;

  Task({
    this.taskname,
    this.orgname,
    this.orgProfileUrl,
    this.orguid,
    this.description,
    this.selectedCategory,
    this.duein,
    this.assignToUserUID,
    this.rewardtitle,
    this.rewarduid,
    this.status,
    this.pointsOffered,
    this.numberofresponses,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskname': taskname,
      'description': description,
      'orgname': orgname,
      'orgProfileUrl': orgProfileUrl,
      'orguid': orguid,
      'categoriesList': selectedCategory,
      'duein': duein,
      'assignToUserUID': assignToUserUID,
      'rewardtitle': rewardtitle,
      'rewarduid': rewarduid,
      'status': status,
      'pointsOffered': pointsOffered,
      'numberofresponses': numberofresponses,
      'createdAt': DateTime.now(),
    };
  }

  Task.fromMap(Map<String, dynamic> map, {this.reference})
      : taskname = map['taskname'],
        description = map['description'],
        orgname = map['orgname'],
        orguid = map['orguid'],
        orgProfileUrl = map['orgProfileUrl'],
        selectedCategory = map['selectedCategory'],
        duein = map['duein'].toDate(),
        assignToUserUID = map['assignToUserUID'],
        rewardtitle = map['rewardtitle'],
        rewarduid = map['rewarduid'],
        status = map['status'],
        pointsOffered = map['pointsOffered'],
        numberofresponses = map['numberofresponses'],
        createdAt = map['createdAt'].toDate();

  Task.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
