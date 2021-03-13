import 'package:flutter/material.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/entity/UserAccount.dart';
import 'package:wastetastic/screens/ResetPasword.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static UserAccount _loggedInUser;

  @override
  void initState() {
    super.initState();
    _loggedInUser = UserAccountMgr.userDetails;
  }

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
                              _loggedInUser.username,
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              _loggedInUser.email,
                              style: TextStyle(fontSize: 19),
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, ResetPassword.id);
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
