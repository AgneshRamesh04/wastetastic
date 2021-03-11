import 'package:flutter/material.dart';
import 'package:wastetastic/Constants.dart';

class Carpark_card extends StatelessWidget {
  //final String carParkNum;
  final String address;
  final String carParkType;
  final String parkingType;
  final String freeParking;
  final int avail_slots;

  Carpark_card(
      {this.address,
      this.carParkType,
      this.parkingType,
      this.freeParking,
      this.avail_slots});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              "$address. "
              "\nCar Park Type: $carParkType \nParking Type: $parkingType"
              "\nFree Parking: $freeParking",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          VerticalDivider(
            width: 10.0,
            thickness: 10.0,
            color: Colors.red,
          ),
          Column(
            children: [
              Text(
                'Vacant:',
                style: TextStyle(fontSize: 15),
              ),
              Text(
                avail_slots.toString(),
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
