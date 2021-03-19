import 'package:flutter/cupertino.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:flutter/material.dart';
import 'package:wastetastic/screens/CarParkScreen.dart';
import 'package:wastetastic/screens/FavouritesScreen.dart';
import 'package:wastetastic/screens/CatalogScreen.dart';
import 'package:wastetastic/screens/NearYouScreen.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';

class POI_DetialScreen extends StatefulWidget {
  static bool favChanged = false;
  static const String id = 'POI_detail_screen';
  @override
  _POI_DetialScreenState createState() => _POI_DetialScreenState();
}

class _POI_DetialScreenState extends State<POI_DetialScreen> {
  @override
  void initState() {
    POI_DetialScreen.favChanged = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WastePOI POI = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wastetastic'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              child: Column(children: [
                header_card(
                  title: POI.POI_name,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Category: \t',
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                POI.wasteCategory
                                    .toString()
                                    .split('.')
                                    .last
                                    .replaceAll('_', ' '),
                                style: TextStyle(
                                  letterSpacing: 1,
                                  height: 1.2,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'About:      \t',
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                POI.POI_description.trim(),
                                style: TextStyle(
                                  letterSpacing: 1,
                                  height: 1.2,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Address:  \t',
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                POI.address.trim() +
                                    '. Singapore ' +
                                    POI.POI_postalcode.toString(),
                                style: TextStyle(
                                  letterSpacing: 1,
                                  height: 1.2,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton.icon(
                      onPressed: () {
                        setState(() {
                          UserAccountMgr.editFav(POI);
                          POI_DetialScreen.favChanged =
                              !POI_DetialScreen.favChanged;
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
                ),
                SizedBox(
                  height: 25,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
