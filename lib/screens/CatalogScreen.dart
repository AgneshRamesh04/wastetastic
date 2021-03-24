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
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/screens/MapScreen.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String selectedCategory = 'LIGHTING WASTE';
  List<WastePOI> WastePOIs;

  List<POI_card> build_cat_cards(List<WastePOI> POIs) {
    List<POI_card> catalog_Cat = [];
    for (WastePOI wPOI in POIs) {
      catalog_Cat.add(
        POI_card(
          name: wPOI.POI_name,
          address: wPOI.address.trim(),
          postalcode: wPOI.POI_postalcode,
          description: wPOI.POI_description,
          wasteCategory: selectedCategory,
          fav: UserAccountMgr.isFav(wPOI),
          TO_POI_page: () async {
            await Navigator.pushNamed(
              context,
              POI_DetialScreen.id,
              arguments: wPOI,
            );
            if (POI_DetialScreen.favChanged) setState(() {});
          },
          FavFunct: () {
            setState(() {
              UserAccountMgr.editFav(wPOI);
            });
          },
        ),
      );
    }
    return catalog_Cat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
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
                    items: kWasteCategory
                        .map<DropdownMenuItem<String>>((String value) {
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
                          ('WasteCategory.' +
                              selectedCategory.replaceAll(' ', '_'))),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data.docs;
                        print('Inside builder $snapshot');
                        WastePOIs =
                            CatalogMgr.getWastePOIFromSnapshots(documents);

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
              ),
            ],
          ),
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
                            'title': selectedCategory + ' Catalog',
                            'WastePOI': WastePOIs
                          },
                        );
                        // Add your onPressed code here!
                      },
                      child: const Icon(Icons.map),
                      backgroundColor: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
