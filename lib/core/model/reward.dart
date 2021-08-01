import 'package:cloud_firestore/cloud_firestore.dart';

class Reward {
  String title;
  String vouchercode;
  DateTime validTill;
  DateTime createdAt;
  String companyuid;
  DocumentReference reference;

  Reward({
    this.title,
    this.vouchercode,
    this.validTill,
    this.createdAt,
    this.companyuid,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'vouchercode': vouchercode,
      'validTill': validTill,
      'createdAt': DateTime.now(),
      'companyuid': companyuid,
    };
  }

  Reward.fromMap(Map<String, dynamic> map, {this.reference})
      : title = map['title'],
        vouchercode = map['vouchercode'],
        validTill = map['validTill'].toDate(),
        companyuid = map['companyuid'],
        createdAt = map['createdAt'].toDate();

  Reward.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
