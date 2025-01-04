import 'package:flutter/material.dart';
import 'globalNavigatorBar.dart'; // Import the global navigation bar

class BookingsPage extends StatefulWidget {
  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  // For managing which tab is selected
  int selectedTabIndex = 0;

  // Example data for each booking status
  final List<Map<String, String>> bookings = [
    {
      'salon': 'Royal Salon',
      'date': 'Sept. 25, Thurs',
      'services': 'Beard, Haircut - €85',
      'image': 'assets/images/salon1.webp',
    },
    {
      'salon': 'La Coiffure Salon',
      'date': 'Sept. 28, Sat',
      'services': 'Hair Color - €55',
      'image': 'assets/images/salon2.jpeg',
    },
  ];

  // Tab names
  final List<String> tabs = [
    'Upcoming',
    'Completed',
    'Missed',
    'Cancelled'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4),
      appBar: AppBar(
        backgroundColor: Color(0xFF8DA9C4),
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.black),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning, Maloud',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  'Paris, France',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Selector
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Booking Orders',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          // Horizontal scrollable tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Horizontal scrolling
              child: Row(
                children: List.generate(tabs.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTabIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      margin: EdgeInsets.only(right: 8), // Add margin for spacing between buttons
                      decoration: BoxDecoration(
                        color: selectedTabIndex == index ? Colors.black : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: selectedTabIndex == index ? Colors.transparent : Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          color: selectedTabIndex == index ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Booking List
          Expanded(
            child: ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              booking['image']!,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  booking['salon']!,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  booking['date']!,
                                  style: TextStyle(color: Colors.black54),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  booking['services']!,
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Global Navigation Bar with booking calendar navigation
      bottomNavigationBar: GlobalNavigationBar(selectedIndex: 1), // Booking is index 1 here
    );
  }
}
