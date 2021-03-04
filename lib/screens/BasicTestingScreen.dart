import 'package:flutter/material.dart';
import 'package:wastetastic/control/DatabaseCreator.dart';
import 'package:wastetastic/control/CatalogMgr.dart';
import 'package:wastetastic/entity/WasteCategory.dart';

class BasicTestingScreen extends StatefulWidget {
  static const String id = 'basic_testing_screen';
  @override
  _BasicTestingScreenState createState() => _BasicTestingScreenState();
}

class _BasicTestingScreenState extends State<BasicTestingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          onPressed: () {
            //DatabaseCreator.createDatabaseForEWaste();
            //DatabaseCreator.createDatabaseForLightingWaste();
            //DatabaseCreator.createDatabaseForWasteTreatment();
            //DatabaseCreator.createDatabaseForCashForTrash();
            //DatabaseCreator.createDatabaseForGeneralWasteCollectors();
            //DatabaseCreator.createDatabaseForCarPark();
            CatalogMgr.readWastePOIByCategory(WasteCategory.LIGHTING_WASTE);
          },
        ),
      ),
    );
  }
}
