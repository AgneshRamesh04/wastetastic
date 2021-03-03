import 'package:flutter/material.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';

class CarParkScreen extends StatefulWidget {
  static const String id = 'Car_park_screen';
  @override
  _CarParkScreenState createState() => _CarParkScreenState();
}

class _CarParkScreenState extends State<CarParkScreen> {
  @override
  Widget build(BuildContext context) {
    final WastePOI POI = ModalRoute.of(context).settings.arguments;

    return MaterialApp(
      home: SafeArea(
        maintainBottomViewPadding: true,
        top: true,
        left: true,
        bottom: true,
        right: true,
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
                    children: [
                      Text('Near ' + POI.POI_name),
                    ], //POI_cards
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
