import 'package:flutter/material.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          header_card(
            title: 'Profile',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[850],
                        boxShadow: kContainerElevation),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 100.0,
                        ),
                        SizedBox(
                          width: 10,
                          height: 5,
                        ),
                        Column(
                          children: [
                            Text(
                              'Username',
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Email',
                              style: TextStyle(fontSize: 19),
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              onPressed: () {
                                print("Password change");
                                //@todo redirect to change password page and logic
                              },
                              child: Text('   Reset Password   '),
                            )
                          ],
                        )
                      ],
                    ),
                  ), //profile info
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 5,
                  ),
                  header_card(
                    title: 'Waste Disposal Data Analysis',
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
