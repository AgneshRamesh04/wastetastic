import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/entity/WasteRecord.dart';

class WasteRecordMgr {
  static final _firestore = FirebaseFirestore.instance;
  static addNewRecord(String username, DateTime dateTime, double weight,
      WasteCategory category) async {
    WasteRecord wasteRecord = WasteRecord(
      dateTime: dateTime,
      weight: weight,
      category: category,
    );
    wasteRecord.printDetails();
    print(dateTime.millisecondsSinceEpoch.toString());
    _firestore
        .collection('UserAccounts')
        .doc('$username')
        .collection('WasteRecords')
        .doc(dateTime.millisecondsSinceEpoch.toInt().toString())
        .set({
      'weight': weight,
      'category': category.toString(),
    });
    await UserAccountMgr.readUserDetails(username);
    UserAccountMgr.userDetails.printUserDetails();
  }
}
