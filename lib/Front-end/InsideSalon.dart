import 'package:flutter/material.dart';
import 'globalNavigatorBar.dart'; // Import the global navigation bar
import 'OrderConfrmation.dart';

class InsideSalon extends StatefulWidget {
  @override
  _InsideSalonState createState() => _InsideSalonState();
}

class _InsideSalonState extends State<InsideSalon> {
  Map<String, int> serviceCounts = {
    'Hair Cut': 0,
    'Hair Color': 0,
    'Beard': 0,
    'Spa': 0,
  };

  bool showBottomBar = false; // Flag to control bottom bar visibility

  int getTotalItems() {
    return serviceCounts.values.fold(0, (sum, count) => sum + count);
  }

  void _incrementService(String serviceName) {
    setState(() {
      serviceCounts[serviceName] = (serviceCounts[serviceName] ?? 0) + 1;
      if (!showBottomBar && getTotalItems() > 0) {
        showBottomBar = true; // Show the bottom bar when an item is added
      }
    });
  }

  void _decrementService(String serviceName) {
    setState(() {
      if ((serviceCounts[serviceName] ?? 0) > 0) {
        serviceCounts[serviceName] = (serviceCounts[serviceName] ?? 0) - 1;
      }

      if (getTotalItems() == 0) {
        showBottomBar = false; // Hide the bottom bar when no items are left
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4), // Background color similar to the image
      appBar: AppBar(
        backgroundColor: Color(0xFF8DA9C4), // AppBar background matching the background
        elevation: 0, // Remove the shadow
        automaticallyImplyLeading: true, // Enable the back arrow
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.black), // User profile icon
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
            icon: Icon(Icons.notifications, color: Colors.black), // Notification icon
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0), // Add bottom padding
            children: [
              // Salon Image
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/salon1.webp', // Path to salon image
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              // Salon Details
              Text(
                'Royal Salon',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.black54),
                  Text(
                    'Paris, France',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Spacer(),
                  Icon(Icons.star, color: Colors.amber),
                  Text(
                    '5 ★',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '2000 Ratings',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  // Add functionality for booking now
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Book Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              // Services List
              Text(
                'Services',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 15),
              _buildServiceCard('Hair Cut', '€50'),
              SizedBox(height: 10),
              _buildServiceCard('Hair Color', '€100'),
              SizedBox(height: 10),
              _buildServiceCard('Beard', '€35'),
              SizedBox(height: 10),
              _buildServiceCard('Spa', '€100'),
            ],
          ),
          _buildBottomBarWithAnimation(),
        ],
      ),
      bottomNavigationBar: GlobalNavigationBar(selectedIndex: 0), // Global Navigation Bar
    );
  }

  // Helper function to build service cards
  Widget _buildServiceCard(String serviceName, String price) {
    int count = serviceCounts[serviceName] ?? 0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                serviceName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                price,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
          count == 0
              ? ElevatedButton(
                  onPressed: () => _incrementService(serviceName),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.add, color: Colors.white),
                    ],
                  ),
                )
              : Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, color: Colors.black),
                      onPressed: () => _decrementService(serviceName),
                    ),
                    Text(
                      '$count',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.black),
                      onPressed: () => _incrementService(serviceName),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  // Animated Bottom Bar with Animation
  Widget _buildBottomBarWithAnimation() {
    int totalItems = getTotalItems();
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: showBottomBar ? 0 : -100, // Animate the bottom bar to slide in and out
      left: 0,
      right: 0,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$totalItems Items added',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                // Show date and time picker
                _showDateTimePicker(context);
              },
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show date and time picker with increased size
  void _showDateTimePicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      DateTime? selectedDate;
      String? selectedTimeSlot;

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4, // Increased height
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Date & Time Slot',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // Date Picker
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    },
                    child: Text(
                      selectedDate != null
                          ? selectedDate.toString().split(' ')[0]
                          : 'Select Date',
                    ),
                  ),
                  SizedBox(height: 10),
                  // Time Slot Picker
                  DropdownButton<String>(
                    value: selectedTimeSlot,
                    hint: Text('Select Time Slot'),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTimeSlot = newValue;
                      });
                    },
                    items: <String>['10:00 AM - 11:00 AM', '11:00 AM - 12:00 PM', '01:00 PM - 02:00 PM', '02:00 PM - 03:00 PM', '03:00 PM - 04:00 PM']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: selectedDate != null && selectedTimeSlot != null
                        ? () {
                            // Navigate to the confirmation page
                            Navigator.pop(context); // Close the modal
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmationPage(
                                  serviceCounts: serviceCounts,
                                  bookingDate: selectedDate.toString().split(' ')[0],
                                  bookingTime: selectedTimeSlot ?? '',
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Text('Confirm'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
}