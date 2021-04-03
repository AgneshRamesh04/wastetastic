import 'package:flutter/material.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/screens/ProfileScreen.dart';
import 'FavouritesScreen.dart';
import 'HomeScreen.dart';
import 'AddWasteScreen.dart';
import 'BasicTestingScreen.dart';
import 'CatalogScreen.dart';
import 'ProfileScreen.dart';
import 'RecyleInfoScreen.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'MainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPageIndex = 0;

  void refresh() {
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(),
      CatalogScreen(),
      AddWasteScreen(
        notifyMainScreen: refresh,
      ),
      FavouritesScreen(),
      ProfileScreen(),
      //BasicTestingScreen(),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.square(70), //fromHeight(80.0),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                    Colors.green.shade700,
                    Colors.teal.shade700,
                  ])),
            ),
            //backgroundColor: Colors.teal[800],
            automaticallyImplyLeading: false,
            title: Column(
              children: [
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 27.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            AssetImage('assets/images/wastetastic_1.png'),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return RecycleInfoScreen();
                          },
                        );
                      },
                    ),
                    //SizedBox(width: 67),
                    Text('Wastetastic',
                        style: TextStyle(
                            fontSize: 30.0, fontFamily: "DancingScript")),
                    //SizedBox(width: 80),
                    Stack(
                      children: [
                        Icon(
                          Icons.shield,
                          size: 45,
                          color: Colors.green.shade700,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                              width: 45,
                            ),
                            Text(
                              '${UserAccountMgr.userDetails.points}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            centerTitle: true,
          ),
        ),
        body: _widgetOptions.elementAt(_selectedPageIndex),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.green.shade700,
                  Colors.teal.shade700,
                ]),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                //backgroundColor: Colors.green.shade700,
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Catalog',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add Waste',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Favourite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
              /*BottomNavigationBarItem(
                icon: Icon(Icons.build),
                label: 'Test Screen',
              ),*/
            ],
            backgroundColor: Colors.transparent,
            elevation: 0, //Colors.green.shade700,
            currentIndex: _selectedPageIndex,
            selectedItemColor: Colors.lime,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
