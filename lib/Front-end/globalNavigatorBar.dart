import 'package:flutter/material.dart';
import 'customerDashboard.dart';
import 'bookings.dart';
import 'profile.dart';

class GlobalNavigationBar extends StatelessWidget {
  final int selectedIndex;

  GlobalNavigationBar({required this.selectedIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Navigate to the Home screen (CustomerDashboard)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CustomerDashboard()),
        );
        break;
      case 1:
        // Navigate to the Bookings page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BookingsPage()),
        );
        break;
      case 2:
        // Navigate to the Profile page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
