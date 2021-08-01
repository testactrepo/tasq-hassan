import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  String msgTxt;
  DateTime sendAt;
  String sendBy;
  // String senderName;
  DocumentReference reference;

  Message({
    @required this.msgTxt,
    @required this.sendAt,
    @required this.sendBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'msgTxt': msgTxt,
      'sendAt': sendAt,
      'sendBy': sendBy,
      // 'senderName': senderName,
    };
  }

  Message.fromMap(Map<String, dynamic> map, {this.reference})
      : msgTxt = map['msgTxt'],
        sendAt = map['sendAt'].toDate(),
        sendBy = map['sendBy'];
  // senderName = map['senderName'];

  Message.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
