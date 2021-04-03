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
    int new_point = UserAccountMgr.userDetails.points;
    if (category == WasteCategory.NORMAL_WASTE) {
      new_point += 7 * weight.toInt();
    } else if (category == WasteCategory.E_WASTE) {
      new_point += 3 * weight.toInt();
    } else if (category == WasteCategory.LIGHTING_WASTE) {
      new_point += 4 * weight.toInt();
    } else if (category == WasteCategory.WASTE_TREATMENT) {
      new_point += 6 * weight.toInt();
    } else {
      new_point += 9 * weight.toInt();
    }
    _firestore
        .collection('UserAccounts')
        .doc('$username')
        .update({'points': new_point});
    _firestore
        .collection('UserAccounts')
        .doc('$username')
        //.update('points': updated_points);
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
