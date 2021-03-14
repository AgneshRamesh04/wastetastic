import 'package:flutter/material.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/entity/WasteCategory.dart';

class WasteRecord_card extends StatelessWidget {
  //final String carParkNum;
  final String date;
  final String time;
  final String category;
  final double weight;

  WasteRecord_card({this.date, this.time, this.category, this.weight});

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
              '$category\n\n$date - $time',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          VerticalDivider(
            width: 10.0,
            thickness: 10.0,
            color: Colors.red,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Weight:',
                style: TextStyle(fontSize: 15),
              ),
              Text(
                weight.toString(),
                style: TextStyle(
                  fontSize: 45,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
