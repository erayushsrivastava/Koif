import 'package:flutter/material.dart';
import 'shopOwnerNavBar.dart'; // Assuming this is your bottom navigation bar widget
import 'ShopDetails.dart'; // Import ShopDetails.dart file
import 'ServiceRateList.dart'; // Import ServiceRateList.dart
import 'BookingsShopOwner.dart'; // Import BookingsShopOwner.dart
import 'profileShopOwner.dart'; // Import ProfileShopOwner.dart

class ShopOwnerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4), // Light blue background to match theme
      appBar: AppBar(
        backgroundColor: Color(0xFF8DA9C4), // Matching AppBar color
        elevation: 0, // No shadow
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.store, color: Colors.black), // Shop icon
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Salon Stars Dashboard', // Dashboard title
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  'Welcome, Salon Owner', // Placeholder for shop owner’s name
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildInteractiveDashboardSection(
            context,
            'Upload Shop Details',
            Icons.store_mall_directory,
            () => _navigateToShopDetails(context),
          ),
          SizedBox(height: 20),
          _buildInteractiveDashboardSection(
            context,
            'Services and Rate List',
            Icons.list_alt,
            () => _navigateToServices(context),
          ),
          SizedBox(height: 20),
          _buildInteractiveDashboardSection(
            context,
            'Manage Bookings',
            Icons.calendar_today,
            () => _navigateToBookings(context),
          ),
          SizedBox(height: 20),
          _buildInteractiveDashboardSection(
            context,
            'Profile Settings',
            Icons.person,
            () => _navigateToProfileShopOwner(context), // Updated navigation
          ),
        ],
      ),
      bottomNavigationBar: ShopOwnerNavBar(selectedIndex: 0), // Assuming you have this in place
    );
  }

  // Helper function to build interactive dashboard sections with darker colors
  Widget _buildInteractiveDashboardSection(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C3E50), Color(0xFF4B79A1)], // Darker gradient background for button
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30), // More rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 15,
              spreadRadius: 5,
              offset: Offset(0, 10), // Shadow position for elevated effect
            ),
          ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2), // Subtle background for the icon
              ),
              child: Icon(
                icon,
                size: 40,
                color: Colors.white, // Icon color changed to white for contrast
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color changed to white
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white, // Arrow icon color updated
            ),
          ],
        ),
      ),
    );
  }

  // Navigation Handlers
  void _navigateToShopDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShopDetails()),
    );
  }

  void _navigateToServices(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ServiceRateList()),
    );
  }

  void _navigateToBookings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingsShopOwner()),
    );
  }

  void _navigateToProfileShopOwner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileShopOwner()),
    );
  }
}
