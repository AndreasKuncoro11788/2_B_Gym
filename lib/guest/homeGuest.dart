import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/view_list.dart'; 
import 'package:flutter_application_1/guest/isi_homeGuest.dart'; 
import 'package:flutter_application_1/guest/profileGuest.dart'; 

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> widgetOptions = <Widget>[
    Center(
      child: IsiHomeGuest(), 
    ),
    ListViewScreen(),
    Center(
      child: ProfileGuest(), 
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(milliseconds: 300),
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: Colors.pink),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_outlined),
            selectedIcon: Icon(Icons.list_rounded, color: Colors.pink),
            label: 'List',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_rounded, color: Colors.pink),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}