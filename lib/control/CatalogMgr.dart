import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogMgr {
  static final _firestore = FirebaseFirestore.instance;
  static readAllWastePOI() async {
    int count = 0;
//    final waste_POI_data = await _firestore.collection('WastePOI').get();
//    print('done!');
//    print(waste_POI_data.docs.length);
    await for (var snapshot in _firestore.collection('WastePOI').snapshots()) {
      for (var waste_POI in snapshot.docs) {
        print(waste_POI.data());
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
        count++;
      }
    }
  }
}
