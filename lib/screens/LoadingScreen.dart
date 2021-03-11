import 'package:flutter/material.dart';
import 'package:wastetastic/control/NearYouMgr.dart';
import 'package:wastetastic/screens/NearYouScreen.dart';
import 'package:geopoint/geopoint.dart' as gp;

class LoadingScreen extends StatefulWidget {
  static String id = "Loading Page";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String title;
  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    //@todo add code for near by POI logic
    gp.GeoPoint location = await NearYouMgr.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
    Navigator.pushReplacementNamed(
      context,
      NearYouScreen.id,
      arguments: {
        'title': title,
        'location': location,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    title = ModalRoute.of(context).settings.arguments;
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            height: 125.0,
            width: 125.0,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
