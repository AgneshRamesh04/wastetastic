import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:geopoint/geopoint.dart' as gp;
import 'package:latlong/latlong.dart';

class CatalogMgr {
  static final _firestore = FirebaseFirestore.instance;
  static Future<List<WastePOI>> readWastePOIByCategory(
      WasteCategory wasteCategory) async {
    int count = 0;
    List<WastePOI> WastePOIs = [];
    List<String> nearbyCarParks = List<String>();
    await for (var snapshot in _firestore
        .collection('WastePOI')
        .where('category', isEqualTo: wasteCategory.toString())
        .snapshots()) {
      for (var waste_POI in snapshot.docs) {
        //print(waste_POI.data());
        nearbyCarParks = [];
        print('Count: ' + count.toString());
        Map<String, dynamic> w = waste_POI.data();
        print('Postal Code: ' + w['POI_postalcode'].toString());
        print('Address:' + w['address']);
        print('POI Desc: ' + w['POI_description']);
        print('Name: ' + w['name']);
        print('POI inc crc: ' + w['POI_inc_crc']);
        print('POI feml upd d: ' + w['POI_feml_upd_d']);
        print('Lat Long: ' +
            w['location'].latitude.toString() +
            " " +
            w['location'].longitude.toString());
        print('Category: ' + w['category']);
        print('Nearby Car Parks: ');
        for (String carParkNum in w['nearbyCarPark']) {
          nearbyCarParks.add(carParkNum);
          print(carParkNum);
        }
        count++;
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
    }
    return WastePOIs;
  }

  static getWastePOISnapshotsByCategory(WasteCategory wasteCategory) {
    return _firestore
        .collection('WastePOI')
        .where('category', isEqualTo: wasteCategory.toString())
        .snapshots();
  }

  static List<WastePOI> getWastePOIFromSnapshots(
      List<DocumentSnapshot> documents) {
    List<WastePOI> WastePOIs = List<WastePOI>();
    List<String> nearbyCarParks = List<String>();
    for (var w in documents) {
      nearbyCarParks = [];
      for (String carParkNum in w['nearbyCarPark']) {
        nearbyCarParks.add(carParkNum);
        print(carParkNum);
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
    return WastePOIs;
//    return documents.map((document) => WastePOI(
//          name: document['name'],
//          category: WasteCategory.values.firstWhere(
//              (element) => element.toString() == document['category']),
//          location: gp.GeoPoint.fromLatLng(
//              point: LatLng(document['location'].latitude,
//                  document['location'].longitude)),
//          address: document['address'],
//          POI_postalcode: document['POI_postalcode'],
//          nearbyCarPark: document['nearbyCarPark'],
//          POI_description: document['POI_description'],
//          POI_inc_crc: document['POI_inc_crc'],
//          POI_feml_upd_d: document['POI_feml_upd_d'],
//        ));
  }

  static readAllWastePOI() async {
    int count = 0;
    List<WastePOI> WastePOIs = [];
    List<String> nearbyCarParks = List<String>();
    await for (var snapshot in _firestore.collection('WastePOI').snapshots()) {
      for (var waste_POI in snapshot.docs) {
        //print(waste_POI.data());
        nearbyCarParks = [];
        print('Count: ' + count.toString());
        Map<String, dynamic> w = waste_POI.data();
        print('Postal Code: ' + w['POI_postalcode'].toString());
        print('Address:' + w['address']);
        print('POI Desc: ' + w['POI_description']);
        print('Name: ' + w['name']);
        print('POI inc crc: ' + w['POI_inc_crc']);
        print('POI feml upd d: ' + w['POI_feml_upd_d']);
        print('Lat Long: ' +
            w['location'].latitude.toString() +
            " " +
            w['location'].longitude.toString());
        print('Category: ' + w['category']);
        print('Nearby Car Parks: ');
        for (String carParkNum in w['nearbyCarPark']) {
          nearbyCarParks.add(carParkNum);
          print(carParkNum);
        }
        count++;
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
    }
    return WastePOIs;
  }
}
