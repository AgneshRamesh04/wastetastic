import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wastetastic/control/CatalogMgr.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/widgets/POICard.dart';
import 'package:wastetastic/control/NearYouMgr.dart';
import 'package:geopoint/geopoint.dart' as gp;

import 'package:wastetastic/Constants.dart';
import 'MapScreen.dart';
import 'POIDetailsScreen.dart';

class NearYouScreen extends StatefulWidget {
  static const String id = 'Near_You_Screen';

  @override
  _NearYouScreenState createState() => _NearYouScreenState();
}

class _NearYouScreenState extends State<NearYouScreen> {
  List<WastePOI> WastePOIs;
  String title;

  List<POI_card> build_nearby_cards(List<WastePOI> nearbyWastePOI) {
    List<POI_card> nearbyPOI = [];
    for (WastePOI w in nearbyWastePOI) {
      String POICategory = w.wasteCategory.toString().split('.').last;
      POICategory = POICategory.replaceAll('_', ' ');
      if (POICategory == title.toUpperCase()) //&& w.location <= 20km
        nearbyPOI.add(
          POI_card(
            name: w.POI_name,
            address: w.address.trim(),
            postalcode: w.POI_postalcode,
            description: w.POI_description,
            wasteCategory: POICategory,
            fav: UserAccountMgr.isFav(w),
            TO_POI_page: () async {
              await Navigator.pushNamed(
                context,
                POI_DetialScreen.id,
                arguments: w,
              );
              if (POI_DetialScreen.favChanged) setState(() {});
            },
            FavFunct: () {
              setState(() {
                UserAccountMgr.editFav(w);
              });
            },
          ),
        );
    }
    return nearbyPOI;
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final gp.GeoPoint location = arguments['location'];
    title = arguments['title'];

    //@todo get user location and filter nearby locations
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wastetastic'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Column(children: [
              header_card(
                title: title,
              ),
              Text('Nearby Locations:'),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder(
                    stream: CatalogMgr.getWastePOISnapshotsByCategory(
                      WasteCategory.values.firstWhere((element) =>
                          element.toString() ==
                          ('WasteCategory.' +
                              title.toUpperCase().replaceAll(' ', '_'))),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data.docs;
                        print('Inside builder $snapshot');
                        WastePOIs = NearYouMgr.retrieveNearbyWastePOI(
                            documents, location);
                        return Column(
                          children: build_nearby_cards(WastePOIs),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            MapScreen.id,
                            arguments: {
                              'title': title + ' WastePOI Near You',
                              'WastePOI': WastePOIs,
                              'location': location,
                            },
                          );
                          // Add your onPressed code here!
                        },
                        child: const Icon(Icons.map),
                        backgroundColor: Colors.green.shade700,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: build_nearby_cards(), //POI_cards
//),
