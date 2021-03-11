import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:wastetastic/entity/UserAccount.dart';

import '../entity/UserAccount.dart';
import '../entity/WasteRecord.dart';
import '../entity/WastePOI.dart';
import 'package:geopoint/geopoint.dart' as gp;
import 'package:latlong/latlong.dart';

class UserAccountMgr {
  static final _firestore = FirebaseFirestore.instance;

  static Future<UserAccount> readUserDetails(String username) async {
    UserAccount userDetails = new UserAccount();

    var userAccount = await _firestore.collection('UserAccounts').doc(username).get(); //getting the username snapshot. Now what does this snapshot comprise of??
    Map<String, dynamic> user = userAccount.data();

    userDetails.username = username;
    userDetails.email = user['email'];
    userDetails.name = user['name'];
    userDetails.points = user['points'];

    List<WastePOI> WastePOIs = List<WastePOI>();

    for (var waste_POI_name in user['favorites']) {
      var w = await _firestore.collection('WastePOI').doc(waste_POI_name).get();
      List<String> nearbyCarParks = List<String>();

      nearbyCarParks = [];
      for (String carParkNum in w['nearbyCarPark']) {
        nearbyCarParks.add(carParkNum);
      }

      WastePOIs.add(WastePOI(
        name: w['name'],
        category: WasteCategory.values
            .firstWhere((element) => element.toString() == w['category']),
        location: gp.GeoPoint.fromLatLng(
            point: LatLng(w['location'].latitude, w['location'].longitude)),
        address: w['address'],
        POI_postalcode: w['POI_postalcode'],
        nearbyCarPark: nearbyCarParks,
        POI_description: w['POI_description'],
        POI_inc_crc: w['POI_inc_crc'],
        POI_feml_upd_d: w['POI_feml_upd_d'],
      ));
    }
    userDetails.favorites = WastePOIs;

    List<WasteRecord> WasteRecords = List<WasteRecord>();
    // var userWasteRecords = await _firestore.collection('UserAccounts').doc(username).collection('WasteCategory');
    // var x={1,2};
    // for( var i in x){
    //   var w= await userWasteRecords.doc(i.toString()).get();
    //
    //   WasteRecords.add(WasteRecord(
    //     dateTime: w['dateTime'],
    //     weight: w['weight'],
    //     category: w['category'],
    //   ));
    //   //print(y);
    // }
    userDetails.waste_records = WasteRecords;

    return userDetails;
  }
}
