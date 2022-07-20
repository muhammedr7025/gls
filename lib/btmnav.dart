import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_password_login/screens/gas_details.dart';
import 'package:email_password_login/screens/home_screen.dart';
import 'package:email_password_login/screens/settings.dart';
import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

class BtmNav extends StatefulWidget {
  const BtmNav({Key? key}) : super(key: key);

  @override
  State<BtmNav> createState() => _BtmNavState();
}

class _BtmNavState extends State<BtmNav> {
  int _selectedIndex = 0;
  final _pages = [HomeScreen(), SettingsStaff()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      // body: Center(child: Text('haiiii')),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: GNav(
            gap: 8,
            padding:
                const EdgeInsets.only(bottom: 16, left: 50, right: 30, top: 16),
            backgroundColor: Colors.orange,
            activeColor: Colors.white,
            color: Colors.black,
            tabBackgroundColor: Colors.red,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
