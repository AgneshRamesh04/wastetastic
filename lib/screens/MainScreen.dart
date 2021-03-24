import 'package:flutter/material.dart';
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
      AddWasteScreen(),
      FavouritesScreen(),
      ProfileScreen(),
      BasicTestingScreen(),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.square(75),  //fromHeight(80.0),
          child:AppBar(
           flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Colors.green.shade700,
                        Colors.teal.shade700,
                      ])
              ),
            ),
          //backgroundColor: Colors.teal[800],
          automaticallyImplyLeading: false,
          title:
              Column(
                children:[
                    SizedBox(height: 15),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: CircleAvatar(
                          radius: 25.0,
                            //backgroundImage: AssetImage('')
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
                      Text('Wastetastic',
                          style: TextStyle(
                              fontSize: 35.0, fontFamily: "Source Sans Pro")),

                      Icon(Icons.pending_actions_rounded)
                    ],
                  ),
                ],
              ),
          centerTitle: true,

          ),
        ),
        body: _widgetOptions.elementAt(_selectedPageIndex),
        bottomNavigationBar: BottomNavigationBar(
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
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              label: 'Test Screen',
            ),
          ],



          backgroundColor: Colors.green.shade700,
          //fixedColor: Colors.green.shade700,
          currentIndex: _selectedPageIndex,
          selectedItemColor: Colors.teal.shade700,
          //fixedColor: Colors.yellowAccent,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey           ,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
