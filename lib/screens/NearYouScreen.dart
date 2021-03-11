import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wastetastic/control/CatalogMgr.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/widgets/POICard.dart';
import 'package:wastetastic/control/NearYouMgr.dart';

import 'package:wastetastic/Constants.dart';
import 'POIDetailsScreen.dart';

class NearYouScreen extends StatefulWidget {
  static const String id = 'Near_You_Screen';
  @override
  _NearYouScreenState createState() => _NearYouScreenState();
}

class _NearYouScreenState extends State<NearYouScreen> {
  List<WastePOI> WastePOIs;
  @override
  Widget build(BuildContext context) {
    final String title = ModalRoute.of(context).settings.arguments;

    List<POI_card> build_nearby_cards() {
      //List<WastePOI> WastePOIs = CatalogMgr.readAllWastePOI();
      List<POI_card> nearbyPOI = [];
      for (WastePOI w in kWastePOI_List) {
        String POICategory = w.wasteCategory.toString().split('.').last;
        POICategory = POICategory.replaceAll('_', ' ');
        if (POICategory == title.toUpperCase()) //&& w.location <= 20km
          nearbyPOI.add(
            POI_card(
              name: w.POI_name,
              address: w.address,
              postalcode: w.POI_postalcode,
              description: w.POI_description,
              wasteCategory: POICategory,
              fav: kFav_POI_list.contains(w),
              TO_POI_page: () {
                Navigator.pushNamed(
                  context,
                  POI_DetialScreen.id,
                  arguments: w,
                );
              },
              FavFunct: () {
                setState(() {
                  if (kFav_POI_list.contains(w))
                    kFav_POI_list.remove(w);
                  else
                    kFav_POI_list.add(w);

                  //@todo add function to favourite/un-favourite POI in the database
                });
              },
            ),
          );
      }
      return nearbyPOI;
    }

    //@todo get user location and filter nearby locations
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wastetastic'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(children: [
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
                      //WastePOIs = NearYouMgr.retrieveNearbyWastePOI(documents);
                      return Column(
                          //children: build_cat_cards(WastePOIs),
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
        ),
      ),
    );
  }
}

//Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: build_nearby_cards(), //POI_cards
//),
