import 'package:cloud_firestore/cloud_firestore.dart';

class TaskApplication {
  String applicantName;
  String applicantUID;
  String applicantDP;
  String proposal;
  String taskuid;
  String tasktitle;
  int taskpoints;
  DateTime appliedat;
  DocumentReference reference;

  TaskApplication({
    this.applicantName,
    this.proposal,
    this.tasktitle,
    this.taskpoints,
    this.appliedat,
  });

  Map<String, dynamic> toMap() {
    return {
      'applicantName': applicantName,
      'applicantUID': applicantUID,
      'applicantDP': applicantDP,
      'taskuid': taskuid,
      'tasktitle': tasktitle,
      'proposal': proposal,
      'taskpoints': taskpoints,
      'applied_at': DateTime.now(),
    };
  }

  TaskApplication.fromMap(Map<String, dynamic> map, {this.reference})
      : applicantName = map['applicantName'],
        applicantUID = map['applicantUID'],
        applicantDP = map['applicantDP'],
        taskuid = map['taskuid'],
        tasktitle = map['tasktitle'],
        proposal = map['proposal'],
        appliedat = map['applied_at'].toDate(),
        taskpoints = map['taskpoints'];

  TaskApplication.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
