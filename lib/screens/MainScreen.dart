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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Icon(Icons.restore_from_trash),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return RecycleInfoScreen();
                    },
                  );
                },
              ),
              Text('Wastetastic'),
              Icon(Icons.pending_actions_rounded)
            ],
          ),
          centerTitle: true,
        ),
        body: _widgetOptions.elementAt(_selectedPageIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
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
          currentIndex: _selectedPageIndex,
          selectedItemColor: Colors.lightGreenAccent,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
