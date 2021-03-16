import 'package:flutter/material.dart';

class Map extends StatefulWidget {
  static const String id = 'Map';
  @override
  _Map createState() => _Map();
}

class _Map extends State<Map> {
  bool changed = false;
  @override
  // void initState() {
  //   super.initState();
  //   UserAccountMgr.userDetails.printUserDetails();
  // }

  Widget build(BuildContext context) {
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
      ),
    );
  }
}
