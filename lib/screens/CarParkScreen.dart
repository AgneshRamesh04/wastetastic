import 'package:flutter/material.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/control/CarParkMgr.dart';
import 'package:wastetastic/entity/CarPark.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/widgets/CarparkCard.dart';

class CarParkScreen extends StatefulWidget {
  static const String id = 'Car_park_screen';
  @override
  _CarParkScreenState createState() => _CarParkScreenState();
}

class _CarParkScreenState extends State<CarParkScreen> {
  @override
  Widget build(BuildContext context) {
    final WastePOI POI = ModalRoute.of(context).settings.arguments;

    List<Widget> build_carpark_cards(List<List> carParkList) {
      //List<WastePOI> favorites = retrieveFavoritesFromDatabase(username)
      List<Widget> carpark_card_list = [
        Center(child: Text('Near ' + POI.POI_name)),
        SizedBox(
          height: 5,
        )
      ];
      for (List cp in carParkList) {
        carpark_card_list.add(Carpark_card(
          address: cp[0].address,
          freeParking: cp[0].freeParking,
          carParkType: cp[0].carParkType,
          parkingType: cp[0].parkingType,
          avail_slots: int.parse(cp[1]),
        ));
      }
      return carpark_card_list;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wastetastic'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(children: [
            header_card(
              title: 'Car Parking Facilities',
            ),
            Expanded(
                child: FutureBuilder(
                    future:
                        CarParkMgr.retrieveNearbyCarParkInfo(POI.nearbyCarPark),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                build_carpark_cards(snapshot.data), //POI_cards
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
          ]),
        ),
      ),
    );
  }
}
