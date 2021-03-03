import 'package:flutter/services.dart';
import 'package:geojson/geojson.dart';
import 'package:geopoint/geopoint.dart' as gp;
import 'package:latlong/latlong.dart';
import 'package:wastetastic/entity/CarPark.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:html/parser.dart' as html;
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:csv/csv.dart';
import 'package:geocoder/geocoder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sortedmap/sortedmap.dart';

import '../entity/WasteCategory.dart';
import '../entity/WastePOI.dart';

const String carParkDataURL =
    'https://data.gov.sg/api/action/datastore_search?resource_id=139a3035-e624-4f56-b63f-89ae28d4ae4c&limit=4094';

class DatabaseCreator {
  static final _firestore = FirebaseFirestore.instance;

  static getTop5CarPark(gp.GeoPoint location) async {
    final Distance distance = Distance();
    Map<String, LatLng> listOfCarParkLocations = await readAllCarParks();
    double m;
    var distances = SortedMap(Ordering.byValue());
    print(distances);
    for (String key in listOfCarParkLocations.keys) {
      m = distance.as(
          LengthUnit.Meter, location.toLatLng(), listOfCarParkLocations[key]);
      distances.addAll({key: m});
//        print("$key: ${distances[key]}");
    }
    print(distances);
    List<String> nearbyCarpark = List<String>();
    int counter = 0;
    for (var carParkNum in distances.keys) {
      if (counter == 5) break;
      nearbyCarpark.add(carParkNum);
      counter++;
    }
    return nearbyCarpark;
  }

  static readAllCarParks() async {
    Map<String, LatLng> listOfCarParkLocations = Map<String, LatLng>();
    await for (var snaps in _firestore.collection('CarPark').snapshots()) {
      for (var carpark in snaps.docs) {
        Map<String, dynamic> c = carpark.data();
        listOfCarParkLocations[carpark.id] =
            LatLng(c['location'].latitude, c['location'].longitude);
      }
      return listOfCarParkLocations;
    }
  }

  static createDatabaseForEWaste() async {
    String rawGeoJson = await rootBundle
        .loadString('assets/databases/e-waste-recycling-geojson.geojson');
    final features = await featuresFromGeoJson(rawGeoJson);
    int count = 0;
    //print(jsonDecode(rawGeoJson));
    String name, POI_desc, POI_inc_crc, POI_feml_upd_d, address;
    int postalCode;
    gp.GeoPoint location;
    WasteCategory category = WasteCategory.E_WASTE;
    for (final feature in features.collection) {
      dynamic HTML_description = feature.properties['Description'];
      var table = html.parse(HTML_description);
      name = table.getElementsByTagName('td')[0].text;
      postalCode = int.parse(table.getElementsByTagName('td')[3].text);
      address = table.getElementsByTagName('td')[6].text +
          " " +
          table.getElementsByTagName('td')[7].text +
          " " +
          table.getElementsByTagName('td')[8].text +
          " " +
          table.getElementsByTagName('td')[9].text +
          " " +
          table.getElementsByTagName('td')[10].text;
      POI_desc = table.getElementsByTagName('td')[11].text;
      POI_inc_crc = table.getElementsByTagName('td')[12].text;
      POI_feml_upd_d = table.getElementsByTagName('td')[13].text;
      location = feature.geometry.geoPoint;
      List<String> nearbyCarPark = await getTop5CarPark(location);
      WastePOI w = WastePOI(
        name: name,
        category: category,
        location: location,
        address: address,
        POI_postalcode: postalCode,
        nearbyCarPark: nearbyCarPark,
        POI_description: POI_desc,
        POI_inc_crc: POI_inc_crc,
        POI_feml_upd_d: POI_feml_upd_d,
      );
      w.printDetails();
      _firestore.collection('WastePOI').doc('E_WASTE_$count').set({
        'name': name,
        'category': category.toString(),
        'location': GeoPoint(location.latitude, location.longitude),
        'address': address,
        'POI_postalcode': postalCode,
        'POI_description': POI_desc,
        'POI_inc_crc': POI_inc_crc,
        'POI_feml_upd_d': POI_feml_upd_d,
        'nearbyCarPark': nearbyCarPark,
      });
      count++;
//      if (feature.type == GeoJsonFeatureType.point) {
//        print("Latitude: ${feature.geometry.geoPoint.latitude}");
//        print("Longitude: ${feature.geometry.geoPoint.longitude}");
//      }
    }
  }

  static createDatabaseForLightingWaste() async {
    String rawGeoJson = await rootBundle.loadString(
        'assets/databases/lighting-waste-collection-points-geojson.geojson');
    final features = await featuresFromGeoJson(rawGeoJson);
    int count = 0;
    //print(jsonDecode(rawGeoJson));
    String name, POI_desc, POI_inc_crc, POI_feml_upd_d, address;
    int postalCode;
    gp.GeoPoint location;
    WasteCategory category = WasteCategory.LIGHTING_WASTE;
    for (final feature in features.collection) {
      dynamic HTML_description = feature.properties['Description'];
      var table = html.parse(HTML_description);
      name = table.getElementsByTagName('td')[10].text;
      postalCode = int.parse(table.getElementsByTagName('td')[2].text);
      address = table.getElementsByTagName('td')[5].text +
          " " +
          table.getElementsByTagName('td')[6].text +
          " " +
          table.getElementsByTagName('td')[7].text +
          " " +
          table.getElementsByTagName('td')[12].text;
      POI_desc = table.getElementsByTagName('td')[3].text;
      POI_inc_crc = table.getElementsByTagName('td')[13].text;
      POI_feml_upd_d = table.getElementsByTagName('td')[14].text;
      location = feature.geometry.geoPoint;
      print('Count: $count');
      List<String> nearbyCarPark = await getTop5CarPark(location);
      WastePOI w = WastePOI(
        name: name,
        category: category,
        location: location,
        address: address,
        POI_postalcode: postalCode,
        nearbyCarPark: nearbyCarPark,
        POI_description: POI_desc,
        POI_inc_crc: POI_inc_crc,
        POI_feml_upd_d: POI_feml_upd_d,
      );
      w.printDetails();
      _firestore.collection('WastePOI').doc('LIGHTING_WASTE_$count').set({
        'name': name,
        'category': category.toString(),
        'location': GeoPoint(location.latitude, location.longitude),
        'address': address,
        'POI_postalcode': postalCode,
        'POI_description': POI_desc,
        'POI_inc_crc': POI_inc_crc,
        'POI_feml_upd_d': POI_feml_upd_d,
        'nearbyCarPark': nearbyCarPark,
      });
      count++;
//      if (feature.type == GeoJsonFeatureType.point) {
//        print("Latitude: ${feature.geometry.geoPoint.latitude}");
//        print("Longitude: ${feature.geometry.geoPoint.longitude}");
//      }
    }
  }

  static createDatabaseForWasteTreatment() async {
    String rawGeoJson = await rootBundle
        .loadString('assets/databases/waste-treatment-geojson.geojson');
    final features = await featuresFromGeoJson(rawGeoJson);
    int count = 0;
    String name, POI_desc, POI_inc_crc, POI_feml_upd_d, address;
    int postalCode;
    gp.GeoPoint location;
    WasteCategory category = WasteCategory.WASTE_TREATMENT;
    for (final feature in features.collection) {
      dynamic HTML_description = feature.properties['Description'];
      var table = html.parse(HTML_description);
      name = table.getElementsByTagName('td')[10].text;
      postalCode = int.parse(table.getElementsByTagName('td')[3].text);
      address = table.getElementsByTagName('td')[0].text +
          ", " +
          table.getElementsByTagName('td')[1].text +
          " " +
          table.getElementsByTagName('td')[2].text +
          " " +
          table.getElementsByTagName('td')[4].text;
      POI_desc = table.getElementsByTagName('td')[6].text;
      POI_inc_crc = table.getElementsByTagName('td')[12].text;
      POI_feml_upd_d = table.getElementsByTagName('td')[13].text;
      location = feature.geometry.geoPoint;
      List<String> nearbyCarPark = await getTop5CarPark(location);
      WastePOI w = WastePOI(
          name: name,
          category: category,
          address: address,
          location: location,
          POI_postalcode: postalCode,
          nearbyCarPark: nearbyCarPark,
          POI_description: POI_desc,
          POI_feml_upd_d: POI_feml_upd_d,
          POI_inc_crc: POI_inc_crc);
      w.printDetails();
      _firestore.collection('WastePOI').doc('WASTE_TREATMENT_$count').set({
        'name': name,
        'category': category.toString(),
        'location': GeoPoint(location.latitude, location.longitude),
        'address': address,
        'POI_postalcode': postalCode,
        'POI_description': POI_desc,
        'POI_inc_crc': POI_inc_crc,
        'POI_feml_upd_d': POI_feml_upd_d,
        'nearbyCarPark': nearbyCarPark,
      });
      count++;
    }
  }

  static createDatabaseForCashForTrash() async {
    String rawGeoJson = await rootBundle
        .loadString("assets/databases/cash-for-trash-geojson.geojson");
    final features = await featuresFromGeoJson(rawGeoJson);
    int count = 0;
    String name, address, POI_desc, POI_inc_crc, POI_feml_upd_d;
    int postalCode;
    gp.GeoPoint location;
    WasteCategory category = WasteCategory.CASH_FOR_TRASH;
    for (final feature in features.collection) {
      dynamic HTML_Description = feature.properties['Description'];
      var table = html.parse(HTML_Description);
      name = table.getElementsByTagName('td')[13].text;
      address = table.getElementsByTagName('td')[10].text +
          ", " +
          table.getElementsByTagName('td')[9].text +
          ", " +
          table.getElementsByTagName('td')[6].text;
      postalCode = int.parse(table.getElementsByTagName('td')[7].text);
      POI_desc = table.getElementsByTagName('td')[4].text;
      POI_inc_crc = table.getElementsByTagName('td')[11].text;
      POI_feml_upd_d = table.getElementsByTagName('td')[12].text;
      location = feature.geometry.geoPoint;
      List<String> nearbyCarPark = await getTop5CarPark(location);
      WastePOI w = WastePOI(
          name: name,
          category: category,
          address: address,
          POI_description: POI_desc,
          nearbyCarPark: nearbyCarPark,
          POI_inc_crc: POI_inc_crc,
          POI_feml_upd_d: POI_feml_upd_d,
          POI_postalcode: postalCode,
          location: location);
      w.printDetails();
      _firestore.collection('WastePOI').doc('CASH_FOR_TRASH_$count').set({
        'name': name,
        'category': category.toString(),
        'location': GeoPoint(location.latitude, location.longitude),
        'address': address,
        'POI_postalcode': postalCode,
        'POI_description': POI_desc,
        'POI_inc_crc': POI_inc_crc,
        'POI_feml_upd_d': POI_feml_upd_d,
        'nearbyCarPark': nearbyCarPark,
      });
      count++;
    }
  }

  static createDatabaseForGeneralWasteCollectors() async {
    final data = await rootBundle
        .loadString('assets/databases/listing-of-general-waste-collectors.csv');
    List<List<dynamic>> csvData = const CsvToListConverter().convert(data);
    print(csvData[0]);
    WasteCategory category = WasteCategory.NORMAL_WASTE;
    int count = 0;
    String name, address, complete_address;
    int postalCode;
    gp.GeoPoint location;
    bool first = true;
    var coordinates;
    for (var lst in csvData) {
      if (first) {
        first = false;
        continue;
      }
      name = lst[0];
      complete_address = lst[1];
      postalCode = int.parse(complete_address.substring(
          complete_address.length - 6, complete_address.length));
      coordinates =
          (await Geocoder.local.findAddressesFromQuery(complete_address))
              .first
              .coordinates;
      complete_address =
          complete_address.substring(0, complete_address.length - 6);
      location = gp.GeoPoint.fromLatLng(
          point: LatLng(coordinates.latitude, coordinates.longitude));
      List<String> nearbyCarPark = await getTop5CarPark(location);
      WastePOI w = WastePOI(
        name: name,
        category: category,
        POI_postalcode: postalCode,
        nearbyCarPark: nearbyCarPark,
        location: location,
        address: complete_address,
      );
      w.printDetails();
      _firestore.collection('WastePOI').doc('NORMAL_WASTE_$count').set({
        'name': name,
        'category': category.toString(),
        'location': GeoPoint(location.latitude, location.longitude),
        'address': complete_address,
        'POI_postalcode': postalCode,
        'POI_description': 'Normal Waste Disposal',
        'POI_inc_crc': 'No inc_crc',
        'POI_feml_upd_d': 'No feml_upd_d',
        'nearbyCarPark': nearbyCarPark,
      });
      count++;
    }
  }

  static createDatabaseForCarPark() async {
    final data = await rootBundle
        .loadString('assets/databases/hdb-carpark-information.csv');
    List<List<dynamic>> csvData = const CsvToListConverter().convert(data);
    print(csvData[0]);
    String carParkNum, address, carParkType, parkingType, freeParking;
    gp.GeoPoint location;
    bool first = true;
    for (var lst in csvData) {
      if (first) {
        first = false;
        continue;
      }
      carParkNum = lst[0];
      address = lst[1];
      carParkType = lst[4];
      parkingType = lst[5];
      location = gp.GeoPoint.fromLatLng(point: LatLng(lst[12], lst[13]));
      freeParking = lst[7] == 'NO'
          ? 'Paid Parking'
          : 'Free on Sundays and Public Holidays';
      CarPark c = CarPark(
        carParkNum: carParkNum,
        address: address,
        location: location,
        carParkType: carParkType,
        parkingType: parkingType,
        freeParking: freeParking,
      );
      c.printDetails();

      _firestore.collection('CarPark').doc(carParkNum).set({
        'address': address,
        'location': GeoPoint(location.latitude, location.longitude),
        'carParkType': carParkType,
        'parkingType': parkingType,
        'freeParking': freeParking,
      });
    }
  }
}

//IN CASE GOOGLE API IS NEEDED
//    name = csvData[6][0];
//    print('Name: ' + name);
//    complete_address = csvData[6][1];
//    postalCode = int.parse(complete_address.substring(
//        complete_address.length - 6, complete_address.length));
//    print('Postal Code: ' + postalCode.toString());
//    complete_address =
//        complete_address.substring(0, complete_address.length - 6);
//    print('Address: ' + complete_address);
//    coordinates =
//        (await Geocoder.google('GOOGLE-API-KEY')
//                .findAddressesFromQuery(complete_address))
//            .first
//            .coordinates;
//    location = gp.GeoPoint.fromLatLng(
//        point: LatLng(coordinates.latitude, coordinates.longitude));
//    print('Latitude: ' + location.latitude.toString());
//    print('Logintude: ' + location.longitude.toString());
