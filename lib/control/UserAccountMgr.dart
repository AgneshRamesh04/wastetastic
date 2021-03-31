import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  static final _auth = FirebaseAuth.instance;
  static UserAccount userDetails = new UserAccount();

  static readUserDetails(String username) async {
    //UserAccount userDetails = new UserAccount();

    await for (var snapshot in _firestore
        .collection('UserAccounts')
        //.where('username', isEqualTo: username)
        .snapshots()) {
      var documents = snapshot.docs;
      if (documents.isNotEmpty) {
        //print(docs.length);
        for (var Documents in documents) {
          if (Documents.id == username) {
            //print(y);
            //print('Hello There!');
            //print('Doc id' + Doc.id);
            userDetails.username = username;
            userDetails.email = Documents['email'];
            userDetails.name = Documents['name'];
            userDetails.points = Documents['points'];

            List<WastePOI> WastePOIs = List<WastePOI>();
            try {
              for (var waste_POI_name in Documents['favorites']) {
                var w = await _firestore
                    .collection('WastePOI')
                    .doc(waste_POI_name)
                    .get();
                List<String> nearbyCarParks = List<String>();

                nearbyCarParks = [];
                for (String carParkNum in w['nearbyCarPark']) {
                  nearbyCarParks.add(carParkNum);
                }

                WastePOIs.add(WastePOI(
                  id: waste_POI_name,
                  name: w['name'],
                  category: WasteCategory.values.firstWhere(
                      (element) => element.toString() == w['category']),
                  location: gp.GeoPoint.fromLatLng(
                      point: LatLng(
                          w['location'].latitude, w['location'].longitude)),
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
                  print('Hello There!');
                  print('Doc id' + Doc.id);
                  WasteRecords.add(WasteRecord(
                    dateTime:
                        DateTime.fromMillisecondsSinceEpoch(int.parse(Doc.id)),
                    weight: Doc['weight'].toDouble(),
                    category: WasteCategory.values.firstWhere(
                        (element) => element.toString() == Doc['category']),
                  ));
                }
              } else {
                WasteRecords = [];
              }
              break;
            }
            userDetails.waste_records = WasteRecords;
          }
        }
      }
      break;
    }

    //userDetails.printUserDetails();
    //print(userDetails.waste_records.first.weight);
  }

  static bool isFav(WastePOI wp) {
    for (WastePOI w in userDetails.favorites) {
      if (wp.id == w.id) {
        return true;
      }
    }
    return false;
  }

  static Future<void> editFav(WastePOI wp) async {
    if (UserAccountMgr.isFav(wp)) {
      print('Found! in editFav');
      UserAccountMgr.removeFav(wp);
    } else
      userDetails.favorites.add(wp);
    print(userDetails.favorites);
    //@todo add function to favourite/un-favourite POI in the database
    List<String> WastePOI_ids = List<String>();
    for (WastePOI w in userDetails.favorites) WastePOI_ids.add(w.id);
    try {
      await _firestore
          .collection('UserAccounts')
          .doc(userDetails.username)
          .update({'favorites': WastePOI_ids});
    } catch (e) {
      await _firestore
          .collection('UserAccounts')
          .doc(userDetails.username)
          .set({'favorites': WastePOI_ids});
    }
    return;
  }

  static void removeFav(WastePOI wp) {
    for (WastePOI w in userDetails.favorites) {
      if (wp.id == w.id) {
        print('Found! in removeFav');
        userDetails.favorites.remove(w);
        return;
      }
    }
    return;
  }

  static updateUserPassword(String email, String newPassword) async {
    String username;
    await for (var snapshot in _firestore
        .collection('UserAccounts')
        .where('email', isEqualTo: email)
        .snapshots()) {
      var docs = snapshot.docs;
      if (docs.isNotEmpty) {
        for (var Doc in docs) {
          if (Doc['email'] == email) {
            username = Doc.id;
            print(username);
          }
        }
      } else {
        print(
            "No user has this email id registered!"); // figure out how to fix this, maybe check email id in ForgotPassword when the user initially enters an email id
      }
      break;
    }
//    await _firestore
//        .collection('UserAccounts')
//        .doc(username)
//        .update({'password': newPassword});
    var user = _auth.currentUser;
    try {
      await user.updatePassword(newPassword);
    } catch (e) {
      print('Error changing password!');
    }
    await readUserDetails(username);
  }

  static forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static Future<String> validateUsername_Email(
      String username, String email) async {
    await for (var snapshot
        in _firestore.collection('UserAccounts').snapshots()) {
      var documents = snapshot.docs;
      if (documents.isNotEmpty) {
        //print(docs.length);

        for (var Documents in documents) {
          if (Documents.id == username) return "Username";
          if (Documents['email'] == email) return "Email";
        }
      }
      return null;
    }
    return null;
  }
}
