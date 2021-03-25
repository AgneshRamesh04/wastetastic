import 'package:flutter/material.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/entity/UserAccount.dart';
import 'package:wastetastic/screens/ResetPaswordScreen.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/entity/WasteRecord.dart';
import 'package:wastetastic/widgets/WasteRecordCard.dart';

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

  List<Widget> buildWasteRecordCards() {
    List<Widget> wasteRecordCards = [];
    for (WasteRecord WR in _loggedInUser.waste_records) {
      String date = WR.dateTime.toString().substring(0, 10);
      String time = WR.dateTime.toString().substring(11, 19);
      String category = WR.category.toString().split('.').last;
      category = category.replaceAll('_', ' ');
      wasteRecordCards.add(WasteRecord_card(
        time: time,
        date: date,
        category: category,
        weight: WR.weight,
      ));
    }
    return wasteRecordCards;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          header_card(
            title: 'My Profile',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Personal details: ',
                          style: TextStyle(
                              fontSize: 23.0, fontFamily: 'DancingScript')),)),
                      SizedBox(
                        height: 8,),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.lime,
                            boxShadow: kContainerElevation),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_circle,
                              size: 50.0,
                              color: Colors.teal.shade900,
                            ),
                            SizedBox(
                              width: 10,
                              height: 5,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 275,
                                  child: Text(
                                    '${_loggedInUser.username}\n${_loggedInUser.email}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      height: 2,
                                        color: Colors.teal.shade900,
                                    ),
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 5),
                                RaisedButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, ResetPasswordScreen.id,
                                        arguments: {
                                          'email': _loggedInUser.email,
                                          'forgot_password': false,
                                        });
                                  },
                                  child: Text('   Reset Password   ', style: TextStyle(
                                      fontSize: 17.0, color: Colors.teal.shade900)),),

                              ],
                            )
                          ],
                        ),
                      ), //profile info
                      SizedBox(
                        height: 25,
                      ),
                      // Divider(
                      //   thickness: 5,
                      // ),
                      Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('Waste disposal records: ',
                                style: TextStyle(
                                    fontSize: 23.0, fontFamily: 'DancingScript')),)),
                      SizedBox(
                        height: 8,),
                      // header_card(
                      //   title: 'Waste Disposal Data',
                      // ),
                    ] +
                    buildWasteRecordCards(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
