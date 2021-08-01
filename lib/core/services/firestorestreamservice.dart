import 'package:tasq/core/model/chatroom.dart';
import 'package:tasq/core/model/message.dart';
import 'package:tasq/utils/constants/firebasepath.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreStreamService {
  final db = FirebaseFirestore.instance;

  Stream<List<ChatRoom>> chatroomListStream(currentuseruid) {
    return db
        .collection('Tchatroom')
        .where('members', arrayContains: currentuseruid)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ChatRoom.fromSnapshot(doc)).toList());
  }

  Stream<List<Message>> messagesListStream({@required combineuid}) {
    return FirebasePath.chatroom(combineuid)
        .collection('messages')
        .orderBy('sendAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromSnapshot(doc)).toList());
  }
}
