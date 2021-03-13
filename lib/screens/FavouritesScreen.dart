import 'package:flutter/material.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
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
  List<WastePOI> Fav_WastePOI_List;

  @override
  Widget build(BuildContext context) {
    List<POI_card> build_fav_cards() {
      Fav_WastePOI_List = UserAccountMgr.userDetails.favorites;
      //List<WastePOI> favorites = retrieveFavoritesFromDatabase(username)
      List<POI_card> fav_card_list = [];
      for (WastePOI w in Fav_WastePOI_List) {
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
            TO_POI_page: () async {
              var favoriteChanged = await Navigator.pushNamed(
                context,
                POI_DetialScreen.id,
                arguments: w,
              );
              if (favoriteChanged == true) setState(() {});
            },
            FavFunct: () {
              setState(() {
                UserAccountMgr.editFav(w);
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
            child: Column(
              children: build_fav_cards(),
            ),
          ),
        )
      ],
    );
  }
}
