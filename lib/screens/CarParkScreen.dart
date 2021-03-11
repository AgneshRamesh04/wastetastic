import 'package:flutter/material.dart';
import 'package:wastetastic/Constants.dart';
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

    List<Widget> build_carpark_cards() {
      //List<WastePOI> favorites = retrieveFavoritesFromDatabase(username)
      List<Widget> carpark_card_list = [
        Center(child: Text('Near ' + POI.POI_name)),
        SizedBox(
          height: 5,
        )
      ];
      for (CarPark cp in kcarpark_list) {
        carpark_card_list.add(Carpark_card(
          address: cp.address,
          freeParking: cp.freeParking,
          carParkType: cp.carParkType,
          parkingType: cp.parkingType,
          avail_slots: 45,
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
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: build_carpark_cards(), //POI_cards
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
