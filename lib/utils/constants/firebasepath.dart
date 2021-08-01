import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebasePath {
  static final db = FirebaseFirestore.instance;
  //documents
  static DocumentReference users(String useruid) =>
      db.collection("usersT").doc(useruid);
  static DocumentReference organization(String uid) =>
      db.collection("organizationsT").doc(uid);
  static DocumentReference rewards(orgid, rewardsuid) => db
      .collection("organizationsT")
      .doc(orgid)
      .collection('rewards')
      .doc(rewardsuid);
  static DocumentReference tasks(uid) => db.collection("Ttasks").doc(uid);
  static DocumentReference taskApplication(uid) =>
      db.collection("Ttaskapplication").doc(uid);
  static DocumentReference orgMembers(uid) =>
      db.collection("Torgmembers").doc(uid);
  static DocumentReference chatroom(uid) => db.collection("Tchatroom").doc(uid);

  //colectiions
  static CollectionReference usersC() => db.collection("usersT");
  static CollectionReference organizationCollection() =>
      db.collection("organizationsT");
  static CollectionReference orgMembersCollection() =>
      db.collection("Torgmembers");
  static CollectionReference rewardsC(orgid) =>
      db.collection("organizationsT").doc(orgid).collection('rewards');
  static CollectionReference tasksC() => db.collection("Ttasks");
  static CollectionReference taskApplicationC() =>
      db.collection("Ttaskapplication");
}

class StoragePath {
  static final storage = FirebaseStorage.instance;
  static Reference userProfileRef(String useruid) =>
      storage.ref().child('users/$useruid/avatar.png');
  static Reference organizationProfileRef(String useruid) =>
      storage.ref().child('organization/$useruid/avatar.png');
}
