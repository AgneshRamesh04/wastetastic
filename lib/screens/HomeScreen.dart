import 'package:flutter/material.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/screens/LoadingScreen.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/widgets/CategoryButton.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //UserAccountMgr.userDetails.printUserDetails();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          header_card(
            title: 'Recycle Nearby',
          ),

          Container(
            child: Text('Choose waste category for nearby vendors:',
                style: TextStyle(
                    fontSize: 23.0, fontFamily: 'DancingScript')),),
          Expanded(

          child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:20),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CategoryButton(
                      icon: Icons.restore_from_trash,
                      category: 'Normal Waste',
                      redirect: () {
                        Navigator.pushNamed(
                          context,
                          LoadingScreen.id,
                          arguments: 'Normal Waste',
                        );
                      },
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //SizedBox(width: ),
                    //Container(width: 1),
                    CategoryButton(
                      icon: Icons.phone_android,
                      category: 'E Waste',
                      redirect: () {
                        Navigator.pushNamed(
                          context,
                          LoadingScreen.id,
                          arguments: 'E Waste',
                        );
                      },
                    ),
                    CategoryButton(
                      icon: Icons.emoji_objects_outlined,//lightbulb_outline,
                      category: 'Lighting Waste',
                      redirect: () {
                        Navigator.pushNamed(
                          context,
                          LoadingScreen.id,
                          arguments: 'Lighting Waste',
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CategoryButton(
                      icon: Icons.local_fire_department,//flare,//fireplace_outlined,//bubble_chart,//warning_rounded,
                      category: 'Waste Treatment',
                      redirect: () {
                        Navigator.pushNamed(
                          context,
                          LoadingScreen.id,
                          arguments: 'Waste Treatment',
                        );
                      },
                    ),

                    CategoryButton(
                      icon: Icons.attach_money_rounded,
                      category: 'Cash For Trash',
                      redirect: () {
                        Navigator.pushNamed(
                          context,
                          LoadingScreen.id,
                          arguments: 'Cash For Trash',
                        );
                      },
                    ),

                  ],
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          )
          )
          )
        ],
      ),
    );
  }
}
