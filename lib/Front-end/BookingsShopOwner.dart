import 'package:flutter/material.dart';
import 'shopOwnerNavBar.dart'; // Assuming this is your bottom navigation bar widget

class BookingsShopOwner extends StatefulWidget {
  @override
  _BookingsShopOwnerState createState() => _BookingsShopOwnerState();
}

class _BookingsShopOwnerState extends State<BookingsShopOwner> {
  // Sample appointment data that would come from the customer
  final List<Map<String, dynamic>> appointments = [
    {
      'customerName': 'John Doe',
      'appointmentDate': 'Sept. 28, 2024',
      'appointmentTime': '10:00 AM',
      'services': 'Haircut, Beard Trim',
      'status': 'Upcoming'
    },
    {
      'customerName': 'Alice Smith',
      'appointmentDate': 'Sept. 27, 2024',
      'appointmentTime': '12:00 PM',
      'services': 'Hair Color',
      'status': 'Completed'
    },
    {
      'customerName': 'Michael Lee',
      'appointmentDate': 'Sept. 29, 2024',
      'appointmentTime': '3:00 PM',
      'services': 'Spa Treatment',
      'status': 'Upcoming'
    },
    {
      'customerName': 'Laura Brown',
      'appointmentDate': 'Sept. 30, 2024',
      'appointmentTime': '1:00 PM',
      'services': 'Haircut',
      'status': 'Upcoming'
    }
  ];

  // To filter appointments based on tabs (Upcoming, Completed, Missed)
  String selectedTab = 'Upcoming';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4), // Matching background color
      appBar: AppBar(
        backgroundColor: Color(0xFF8DA9C4), // Same color as theme
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.black),
            SizedBox(width: 10),
            Text(
              'Appointments',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Tab selector for 'Upcoming', 'Completed', 'Missed' bookings
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton('Upcoming'),
                _buildTabButton('Completed'),
                _buildTabButton('Missed'),
              ],
            ),
          ),
          // Appointment list based on the selected tab
          Expanded(
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                if (appointment['status'] == selectedTab) {
                  return _buildAppointmentCard(appointment);
                }
                return SizedBox.shrink(); // Don't display if status doesn't match
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ShopOwnerNavBar(selectedIndex: 1), // Index 1 for bookings
    );
  }

  // Helper method to build the tab button
  Widget _buildTabButton(String tabName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = tabName; // Update the selected tab
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selectedTab == tabName ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selectedTab == tabName ? Colors.transparent : Colors.black,
            width: 1.0,
          ),
        ),
        child: Text(
          tabName,
          style: TextStyle(
            color: selectedTab == tabName ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // Helper method to build the appointment card
  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment['customerName'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appointment['services'],
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  appointment['appointmentTime'],
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              appointment['appointmentDate'],
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
