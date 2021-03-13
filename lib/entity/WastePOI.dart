import 'package:flutter/cupertino.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:geopoint/geopoint.dart';
import 'package:wastetastic/entity/CarPark.dart';

class WastePOI {
  String _id;
  String _POI_name;
  WasteCategory _wasteCategory;
  GeoPoint _location;
  List<String> _nearbyCarPark = List<String>(5);
  int _POI_postalcode;
  String _address;
  String _POI_description;
  String _POI_inc_crc;
  String _POI_feml_upd_d;
  double _POI_X;
  double _POI_Y;

  WastePOI({
    @required String id,
    String name,
    WasteCategory category,
    GeoPoint location,
    int POI_postalcode,
    String address,
    List<String> nearbyCarPark,
    String POI_description: 'Normal Waste Disposal',
    String POI_inc_crc: 'No inc_crc',
    String POI_feml_upd_d: 'No feml_upd_d',
  })  : _id = id,
        _POI_name = name,
        _wasteCategory = category,
        _location = location,
        _address = address,
        _POI_postalcode = POI_postalcode,
        _nearbyCarPark = nearbyCarPark,
        _POI_description = POI_description,
        _POI_inc_crc = POI_inc_crc,
        _POI_feml_upd_d = POI_feml_upd_d;

  String get id => _id;
  WasteCategory get wasteCategory => _wasteCategory;
  GeoPoint get location => _location;
  List<String> get nearbyCarPark => _nearbyCarPark;
  String get POI_name => _POI_name;
  String get address => _address;
  int get POI_postalcode => _POI_postalcode;
  String get POI_description => _POI_description;
  String get POI_inc_crc => _POI_inc_crc;
  String get POI_feml_upd_d => _POI_feml_upd_d;
  double get POI_X => _POI_X;
  double get POI_Y => _POI_Y;

  void printDetails() {
    print("Name: $_POI_name");
    print("Address: $_address");
    print("Location: ${location.latitude}, ${location.longitude}");
    print("Postal Code: $_POI_postalcode");
    print("Description: $_POI_description");
    print("Inc crc: $_POI_inc_crc");
    print("Feml Upd d: $_POI_feml_upd_d");
    print("Nearby Car Parks: ");
    for (String carParkNum in _nearbyCarPark) {
      print(carParkNum);
    }
  }
}
