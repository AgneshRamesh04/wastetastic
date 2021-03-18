import 'package:flutter/material.dart';

class header_card extends StatelessWidget {
  final String title;

  header_card({this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            bottom: 10.0,
          ),
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Divider(
          height: 5.0,
          thickness: 5.0,
          indent: 100.0,
          endIndent: 100.0,
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
