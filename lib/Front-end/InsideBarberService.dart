import 'package:flutter/material.dart';
import 'globalNavigatorBar.dart'; // Assuming this is your bottom navigation bar widget
import 'ConfirmationAtHome.dart';

class InsideBarberServices extends StatefulWidget {
  final String barberName;

  InsideBarberServices({required this.barberName});

  @override
  _InsideBarberServicesState createState() => _InsideBarberServicesState();
}

class _InsideBarberServicesState extends State<InsideBarberServices> {
  Map<String, int> selectedServices = {
    'Hair Cut': 0,
    'Hair Color': 0,
    'Beard': 0,
    'Spa': 0,
  };

  bool showBottomBar = false; // Controls the visibility of the pop-up bar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4), // Light blue background
      appBar: AppBar(
        backgroundColor: Color(0xFF8DA9C4), // Matching AppBar color
        elevation: 0, // No shadow
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.black), // User icon
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning, Maloud', // User's name
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  'Paris, France', // User's location
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
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Barber Profile Section
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 80, color: Colors.black), // Placeholder for barber photo
                ),
              ),
              SizedBox(height: 20),
              // Barber Name
              Text(
                widget.barberName, // Display barber name
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.black54),
                  Text(
                    'Paris, France', // Location
                    style: TextStyle(color: Colors.black54),
                  ),
                  Spacer(),
                  Icon(Icons.star, color: Colors.amber),
                  Text(
                    '4.5 ★',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '1000+ Ratings', // Sample rating text
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Book Appointment Button
              ElevatedButton(
                onPressed: () {
                  // Handle booking functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Book Now',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_forward, color: Colors.white), // Forward arrow icon
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Services Section
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
          _buildAnimatedBottomBar(), // Add animated bottom bar
        ],
      ),
      bottomNavigationBar: GlobalNavigationBar(selectedIndex: 0), // Bottom navigation bar
    );
  }

  // Helper function to build each service card
  Widget _buildServiceCard(String serviceName, String price) {
    int count = selectedServices[serviceName] ?? 0;

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

  // Increment service count
  void _incrementService(String serviceName) {
    setState(() {
      selectedServices[serviceName] = (selectedServices[serviceName] ?? 0) + 1;
      if (!showBottomBar) {
        showBottomBar = true; // Show the bottom bar when at least one item is added
      }
    });
  }

  // Decrement service count
  void _decrementService(String serviceName) {
    setState(() {
      if ((selectedServices[serviceName] ?? 0) > 0) {
        selectedServices[serviceName] = (selectedServices[serviceName] ?? 0) - 1;
      }
      if (getTotalItems() == 0) {
        showBottomBar = false; // Hide the bottom bar if all items are removed
      }
    });
  }

  // Function to get total items added
  int getTotalItems() {
    return selectedServices.values.fold(0, (sum, count) => sum + count);
  }

  // Animated Bottom Bar
  Widget _buildAnimatedBottomBar() {
    int totalItems = getTotalItems();
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300), // Animation duration
      curve: Curves.easeInOut, // Smooth curve for animation
      bottom: showBottomBar ? 0 : -100, // Slide up or down based on the flag
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
                // Show date and time picker or any next step
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

  // Show date and time picker when continuing
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
                      items: <String>[
                        '10:00 AM - 11:00 AM',
                        '11:00 AM - 12:00 PM',
                        '01:00 PM - 02:00 PM',
                        '02:00 PM - 03:00 PM',
                        '03:00 PM - 04:00 PM'
                      ].map<DropdownMenuItem<String>>((String value) {
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
                              Navigator.pop(context); // Close the modal
                              // Navigate to the next step
                              Navigator.pop(context); // Close the modal
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmationAtHome(
                                  selectedServices: selectedServices,
                                  barberName: widget.barberName,
                                  bookingDate: selectedDate!.toString().split(' ')[0],
                                  bookingTime: selectedTimeSlot!,
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
