import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/view_list.dart';
import 'package:flutter_application_1/view/isi_home.dart';
import 'package:flutter_application_1/view/home.dart';

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
      child: IsiHomeView(),
    ),
    ListNamaView(),
    Center(
      child: userProfile(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Fixed function call
      ),
      body: widgetOptions.elementAt(_selectedIndex),
    );
  }
}
