import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastetastic/control/CatalogMgr.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/widgets/POICard.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'POIDetailsScreen.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String selectedCategory = 'LIGHTING WASTE';
  List<WastePOI> WastePOIs;
  @override
//  List<WastePOI> getAllWastePOI() {
//    return CatalogMgr.readAllWastePOI();
//  }

//  void initState() {
//    super.initState();
//    WastePOIs = CatalogMgr.readAllWastePOI();
//  }

  Widget build(BuildContext context) {
    List<POI_card> build_cat_cards(List<WastePOI> WastePOIs) {
      List<POI_card> catalog_Cat = [];
      for (WastePOI w in WastePOIs) {
        String POICategory = w.wasteCategory.toString().split('.').last;
        POICategory = POICategory.replaceAll('_', ' ');
        if (POICategory == selectedCategory)
          catalog_Cat.add(
            POI_card(
              name: w.POI_name,
              address: w.address,
              postalcode: w.POI_postalcode,
              description: w.POI_description,
              wasteCategory: POICategory,
              fav: kFav_POI_list.contains(w),
              TO_POI_page: () async {
                var changed = await Navigator.pushNamed(
                  context,
                  POI_DetialScreen.id,
                  arguments: w,
                );
                if (changed) setState(() {});
              },
              FavFunct: () {
                setState(() async {
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
      return catalog_Cat;
    }

    return Column(
      children: [
        header_card(
          title: 'Catalog',
        ),
        SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: DropdownButtonFormField<String>(
              value: selectedCategory,
              icon: Icon(Icons.arrow_drop_down),
              decoration: InputDecoration(
                icon: Icon(Icons.receipt_long),
                prefix: Text("Filter by Waste Category: "),
              ),
              iconSize: 24,
              elevation: 20,
              style: TextStyle(color: Colors.white),
              onChanged: (String newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              dropdownColor: Colors.grey[900],
              items:
                  kWasteCategory.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: CatalogMgr.getWastePOISnapshotsByCategory(
                WasteCategory.values.firstWhere((element) =>
                    element.toString() ==
                    ('WasteCategory.' + selectedCategory.replaceAll(' ', '_'))),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  print('Inside builder $snapshot');
                  WastePOIs = CatalogMgr.getWastePOIFromSnapshots(documents);
                  return Column(
                    children: build_cat_cards(WastePOIs),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
