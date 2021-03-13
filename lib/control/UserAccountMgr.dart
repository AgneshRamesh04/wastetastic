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
  static UserAccount userDetails = new UserAccount();

  static readUserDetails(String username) async {
    //UserAccount userDetails = new UserAccount();

    var userAccount = await _firestore
        .collection('UserAccounts')
        .doc(username)
        .get(); //getting the username snapshot. Now what does this snapshot comprise of??
    Map<String, dynamic> user = userAccount.data();

    userDetails.username = username;
    userDetails.email = user['email'];
    userDetails.name = user['name'];
    userDetails.points = user['points'];

    List<WastePOI> WastePOIs = List<WastePOI>();
    try {
      for (var waste_POI_name in user['favorites']) {
        var w =
            await _firestore.collection('WastePOI').doc(waste_POI_name).get();
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
    } catch (e) {
      //print(e);
      WastePOIs = [];
    }
    userDetails.favorites = WastePOIs;

    List<WasteRecord> WasteRecords = List<WasteRecord>();

    await for (var snapshot in _firestore
        .collection('UserAccounts')
        .doc(username)
        .collection('WasteRecords')
        .snapshots()) {
      var docs = snapshot.docs;
      if (docs.isNotEmpty) {
        print(docs.length);
        for (var Doc in docs) {
          //print(y);
          //print('Hello There!');
          //print('Doc id' + Doc.id);
          WasteRecords.add(WasteRecord(
            dateTime: DateTime.fromMillisecondsSinceEpoch(int.parse(Doc.id)),
            weight: Doc['weight'].toDouble(),
            category: WasteCategory.values
                .firstWhere((element) => element.toString() == Doc['category']),
          ));
        }
      } else {
        WasteRecords = [];
      }
      break;
    }
    userDetails.waste_records = WasteRecords;
    userDetails.printUserDetails();
    //print(userDetails.waste_records.first.weight);
  }

  static bool isFav(WastePOI wp) {
    for (WastePOI w in userDetails.favorites) {
      if (wp.POI_name == w.POI_name && wp.address == w.address) return true;
    }
    return false;
  }

  static bool editFav(WastePOI wp) {
    if (UserAccountMgr.isFav(wp))
      return UserAccountMgr.removeFav(wp);
    else
      userDetails.favorites.add(wp);
    return true;
    //@todo add function to favourite/un-favourite POI in the database
  }

  static bool removeFav(WastePOI wp) {
    for (WastePOI w in userDetails.favorites) {
      if (wp.POI_name == w.POI_name && wp.address == w.address) {
        userDetails.favorites.remove(w);
        return true;
      }
    }
    return false;
  }
}
