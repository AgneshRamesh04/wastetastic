import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String selectedCategory = 'NORMAL WASTE';
  @override
  Widget build(BuildContext context) {
    List<POI_card> build_cat_cards() {
      //List<WastePOI> WastePOIs = retrievePOIFromDatabase();
      List<POI_card> catalog_Cat = [];
      for (WastePOI w in kWastePOI_List) {
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
      return catalog_Cat;
    }

    return MaterialApp(
      home: SafeArea(
        maintainBottomViewPadding: true,
        top: true,
        left: true,
        bottom: true,
        right: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              header_card(
                title: 'Catalog',
              ),
              DropdownButtonFormField<String>(
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
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: build_cat_cards(),
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
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
