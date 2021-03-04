import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/entity/WasteRecord.dart';

class WasteRecordMgr {
  static final _firestore = FirebaseFirestore.instance;
  static addNewRecord(String username, DateTime dateTime, double weight,
      WasteCategory category) {
    WasteRecord wasteRecord = WasteRecord(
      username: username,
      dateTime: dateTime,
      weight: weight,
      category: category,
    );
    _firestore.collection('WasteRecord').doc('$username').set({
      'username': username,
      'dateTime': Timestamp.fromDate(dateTime),
      'weight': weight,
      'category': category.toString(),
    });
  }
}
