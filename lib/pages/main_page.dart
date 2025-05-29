import 'package:flutter/material.dart';
import 'package:warkop_bunny/pages/tabs/home_tab.dart';
import 'package:warkop_bunny/pages/tabs/profile_tab.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // List of pages to display based on the selected index
  static const List<Widget> _pages = <Widget>[
    // Home Tab
    HomeTab(),

    // QR Code Tab
    Center(child: Text('QR Code')),

    // Profile Tab
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body content based on selected index
      body: _pages[_selectedIndex],

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // Tab Home Icon
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          // Tab QR Code Icon
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR Code'),

          // Tab Profile Icon
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
