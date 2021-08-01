import 'package:tasq/core/model/taskapplication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message.dart';

class ChatRoom {
  List<String> members;
  List<String> profileurls;
  List<String> membersname;
  Message recentMsg;
  TaskApplication taskApplication;
  DateTime updatedAt;
  int unreadmessagescount;

  DocumentReference reference;

  ChatRoom();

  Map<String, dynamic> toMap() {
    return {
      'members': members,
      'membersname': membersname,
      'profileurls': profileurls,
      'recentMsg': recentMsg.toMap(),
      'taskApplication': taskApplication.toMap(),
      'updatedAt': updatedAt,
      'unreadmessagescount': FieldValue.increment(1),
    };
  }

  ChatRoom.fromMap(Map<String, dynamic> map, {this.reference})
      : members = List.from(map['members']),
        membersname = List.from(map['membersname']),
        profileurls = List.from(map['profileurls']),
        recentMsg = Message.fromMap(map['recentMsg']),
        taskApplication = TaskApplication.fromMap(map['taskApplication']),
        unreadmessagescount =
            map['unreadmessagescount'] != null ? map['unreadmessagescount'] : 0,
        updatedAt = map['updatedAt'].toDate();

  ChatRoom.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
