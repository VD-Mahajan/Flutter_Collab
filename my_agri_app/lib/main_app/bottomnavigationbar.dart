import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'addpage.dart';
import 'home.dart';
import 'marketplace.dart';
import 'profile.dart';

class BottomNavBarWrapper extends StatefulWidget {
  const BottomNavBarWrapper({Key? key}) : super(key: key);

  @override
  State createState() => _BottomNavBarWrapperState();
}

class _BottomNavBarWrapperState extends State<BottomNavBarWrapper> {
  int _selectedIndex = 0;

  void _updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(_selectedIndex),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _updateSelectedIndex,
      ),
    );
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const AddPage();
      case 2:
        return const MarketPlace();
      case 3:
        return const Profile();
      default:
        return const HomePage();
    }
  }
}

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;
  const BottomNavBar(
      {super.key, required this.selectedIndex, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GNav(
          backgroundColor: Colors.green,
          gap: 8,
          padding: const EdgeInsets.all(10),
          activeColor: Colors.green,
          tabBackgroundColor: Colors.white,
          color: Colors.white,
          selectedIndex: selectedIndex,
          onTabChange: onTabChange,
          tabs: [
            GButton(
              icon: Icons.home,
              text: "Home",
              onPressed: () {},
            ),
            GButton(
              icon: Icons.add,
              text: "Add",
              onPressed: () {},
            ),
            GButton(
              icon: Icons.production_quantity_limits,
              text: "Store",
              onPressed: () {},
            ),
            GButton(
              icon: Icons.person_2_sharp,
              text: "Profile",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
