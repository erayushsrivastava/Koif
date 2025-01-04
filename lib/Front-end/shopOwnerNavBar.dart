// lib/shopOwnerNavBar.dart
import 'package:flutter/material.dart';
import 'shopOwnerDashboard.dart'; // Import the relevant screens
import 'BookingsShopOwner.dart';
import 'profileShopOwner.dart';

class ShopOwnerNavBar extends StatelessWidget {
  final int selectedIndex;

  ShopOwnerNavBar({required this.selectedIndex});

  void _onItemTapped(BuildContext context, int index) {
    // Check if the selected index is different from the current index
    if (index == selectedIndex) return;

    // Navigate to the respective screen based on the index
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ShopOwnerDashboard()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BookingsShopOwner()));
        break;
      case 2:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ProfileShopOwner()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
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
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    );
  }
}
