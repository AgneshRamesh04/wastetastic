import 'package:flutter/cupertino.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:flutter/material.dart';
import 'package:wastetastic/screens/CarParkScreen.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';

class POI_DetialScreen extends StatefulWidget {
  static const String id = 'POI_detail_screen';
  @override
  _POI_DetialScreenState createState() => _POI_DetialScreenState();
}

class _POI_DetialScreenState extends State<POI_DetialScreen> {
  bool changed = false;

  @override
  Widget build(BuildContext context) {
    final WastePOI POI = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wastetastic'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, changed);
            },
          ),
        ),
        body: Container(
          child: Column(children: [
            header_card(
              title: POI.POI_name,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Address: \t' + POI.address + '\n ',
                    ),
                    SizedBox(
                      height: 350,
                    ), //placeholder
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton.icon(
                          onPressed: () {
                            setState(() {
                              UserAccountMgr.editFav(POI);
                              changed = !changed;
                            });
                          },
                          label: Text('Favourite'),
                          icon: Icon(
                            Icons.star,
                            color: UserAccountMgr.isFav(POI)
                                ? Colors.yellow
                                : Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        RaisedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              CarParkScreen.id,
                              arguments: POI,
                            );
                          },
                          label: Text('NearBy CarPark'),
                          icon: Icon(Icons.directions_car_rounded),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
