import 'package:flutter/material.dart';
import 'package:geopoint/geopoint.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:latlong/latlong.dart';

const List<String> kWasteCategory = [
  'NORMAL WASTE',
  'E WASTE',
  'LIGHTING WASTE',
  'WASTE TREATMENT',
  'CASH FOR TRASH'
];

const kContainerElevation = [
  BoxShadow(
    offset: Offset(0.0, 5.0), //(x,y)
    blurRadius: 6.0,
  ),
];

WastePOI kSample = WastePOI(
  name: "WastePOI sample",
  category: WasteCategory.LIGHTING_WASTE,
  location: GeoPoint.fromLatLng(name: "Position", point: LatLng(51.0, 0.0)),
  POI_postalcode: 827373,
  POI_description: "ajsjs",
  address: "PlaceHolder address",
);

WastePOI kSample2 = WastePOI(
  name: "WastePOI sample2",
  category: WasteCategory.E_WASTE,
  location: GeoPoint.fromLatLng(name: "Position", point: LatLng(51.0, 0.0)),
  POI_postalcode: 827373,
  POI_description: "ajsjs",
  address: "PlaceHolder address",
);

WastePOI kSample3 = WastePOI(
  name: "WastePOI sample3",
  category: WasteCategory.NORMAL_WASTE,
  location: GeoPoint.fromLatLng(name: "Position", point: LatLng(51.0, 0.0)),
  POI_postalcode: 827373,
  POI_description: "ajsjs",
  address: "PlaceHolder address",
);

WastePOI kSample4 = WastePOI(
  name: "WastePOI sample4",
  category: WasteCategory.WASTE_TREATMENT,
  location: GeoPoint.fromLatLng(name: "Position", point: LatLng(51.0, 0.0)),
  POI_postalcode: 827373,
  POI_description: "ajsjs",
  address: "PlaceHolder address",
);

WastePOI kSample5 = WastePOI(
  name: "WastePOI sample5",
  category: WasteCategory.CASH_FOR_TRASH,
  location: GeoPoint.fromLatLng(name: "Position", point: LatLng(51.0, 0.0)),
  POI_postalcode: 827373,
  POI_description: "ajsjs",
  address: "PlaceHolder address",
);

WastePOI kSample6 = WastePOI(
  name: "WastePOI sample6",
  category: WasteCategory.CASH_FOR_TRASH,
  location: GeoPoint.fromLatLng(name: "Position", point: LatLng(51.0, 0.0)),
  POI_postalcode: 827373,
  POI_description: "ajsjs",
  address: "PlaceHolder address",
);

List<WastePOI> kWastePOI_List = [
  kSample,
  kSample2,
  kSample3,
  kSample4,
  kSample5,
  kSample6
];

List<WastePOI> kFav_POI_list = [
  kSample,
  kSample2,
  kSample3,
  kSample4,
  kSample5
];

/*[
                    POI_card(
                      name: 'POI1',
                      address: 'address',
                      postalcode: 310204,
                      description: 'description',
                    ),
                    POI_card(
                      name: 'POI2',
                      address: 'address',
                      postalcode: 321045,
                      description: 'description',
                    ),
                    POI_card(
                      name: 'POI3',
                      address: 'address',
                      postalcode: 321045,
                      description: 'description',
                    ),
                  ],*/
