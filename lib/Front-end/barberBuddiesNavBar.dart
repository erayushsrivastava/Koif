// lib/barberBuddiesNavBar.dart
import 'package:flutter/material.dart';
import 'barberBuddiesDashboard.dart';
import 'BookingsBarberBuddies.dart';
import 'ProfileBarberBuddies.dart';

class BarberBuddiesNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<Map<String, String>> acceptedJobs;

  BarberBuddiesNavBar({required this.selectedIndex, required this.acceptedJobs});

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BarberBuddiesDashboard(),
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BookingsBarberBuddies(acceptedJobs: acceptedJobs),
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileBarberBuddies(), // No acceptedJobs here
          ),
        );
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
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
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
