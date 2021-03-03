import 'package:flutter/material.dart';
import 'package:wastetastic/widgets/POICard.dart';
import 'POIDetailsScreen.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    List<POI_card> build_fav_cards() {
      //List<WastePOI> favorites = retrieveFavoritesFromDatabase(username)
      List<POI_card> fav_card_list = [];
      for (WastePOI w in kFav_POI_list) {
        String POICategory = w.wasteCategory.toString().split('.').last;
        POICategory = POICategory.replaceAll('_', ' ');
        fav_card_list.add(
          POI_card(
            name: w.POI_name,
            address: w.address,
            postalcode: w.POI_postalcode,
            description: w.POI_description,
            wasteCategory: POICategory,
            fav: true,
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
      return fav_card_list;
    }

    return Column(
      children: [
        header_card(
          title: 'Favourites',
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: build_fav_cards()
                /*  [
                    POI_card(
                      name: 'POI1',
                      address: 'address',
                      postalcode: 310204,
                      description: 'description',
                      TO_POI_page: () {
                        Navigator.pushNamed(
                          context,
                          POI_DetialScreen.id,
                          arguments: kSample,
                        );
                      },
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
    );
  }
}
