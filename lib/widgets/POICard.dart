import 'package:flutter/material.dart';
import 'package:wastetastic/Constants.dart';

class POI_card extends StatelessWidget {
  final String name;
  final int postalcode;
  final String address;
  final String description;
  final String wasteCategory;
  final Function TO_POI_page;
  final bool fav;
  final Function FavFunct;

  POI_card(
      {this.name,
      this.address,
      this.postalcode,
      this.description,
      this.wasteCategory,
      this.TO_POI_page,
      this.fav,
      this.FavFunct});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: TO_POI_page,
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[900],
          boxShadow: kContainerElevation,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "$name \n$address. Singapore $postalcode "
                "\nCategory: $wasteCategory \n$description",
                overflow: TextOverflow.ellipsis,
              ),
            ),
            VerticalDivider(
              width: 10.0,
              thickness: 10.0,
              color: Colors.red,
            ),
            IconButton(
              onPressed: FavFunct,
              icon: Icon(
                Icons.star,
                color: fav ? Colors.yellow : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
