import 'package:flutter/material.dart';
import 'globalNavigatorBar.dart'; // Import the global navigation bar

class ConfirmationPage extends StatefulWidget {
  final Map<String, int> serviceCounts;
  final String bookingDate;
  final String bookingTime;

  ConfirmationPage({
    required this.serviceCounts,
    required this.bookingDate,
    required this.bookingTime,
  });

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  late Map<String, int> selectedServices;
  late String selectedDate;
  late String selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    // Only keep services where the count is greater than 0
    selectedServices = Map.from(widget.serviceCounts)
      ..removeWhere((key, value) => value <= 0);
    selectedDate = widget.bookingDate;
    selectedTimeSlot = widget.bookingTime;
  }

  void _incrementService(String serviceName) {
    setState(() {
      selectedServices[serviceName] = (selectedServices[serviceName] ?? 0) + 1;
    });
  }

  void _decrementService(String serviceName) {
    setState(() {
      if ((selectedServices[serviceName] ?? 0) > 0) {
        selectedServices[serviceName] = (selectedServices[serviceName] ?? 0) - 1;
      }
    });
  }

  // Use _editDateTime to display date picker
  void _editDateTime(BuildContext context) {
    _showDateTimePicker(context);
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
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
          SizedBox(height: 20),
          // Services List
          Text(
            'Selected Services',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 15),
          // Add spacing between service cards
          ...selectedServices.keys.map((serviceName) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0), // Add some gap between services
              child: _buildServiceCard(serviceName, selectedServices[serviceName] ?? 0),
            );
          }).toList(),
          SizedBox(height: 20),
          // Booking Date and Time
          Text(
            'Booking Date & Time:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              _editDateTime(context); // Edit the date and time
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$selectedDate, $selectedTimeSlot',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Icon(Icons.edit, color: Colors.black54),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBottomBar(context), // Add "Continue & Pay" button at the bottom
          GlobalNavigationBar(selectedIndex: 0), // Add Global Navigation Bar
        ],
      ),
    );
  }

  // Helper function to build service cards
  Widget _buildServiceCard(String serviceName, int count) {
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
                '€${count * 50}', // Assume each service costs €50 for simplicity
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
          Row(
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

  // Bottom bar with continue and pay button
  Widget _buildBottomBar(BuildContext context) {
    return Container(
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
            '${selectedServices.values.fold(0, (sum, count) => sum + count)} Items added',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          GestureDetector(
            onTap: () {
              // Proceed to payment or next steps
            },
            child: Text(
              'Continue & Pay',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Show date and time picker to edit values
  void _showDateTimePicker(BuildContext context) { // This is the renamed function
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        DateTime? newSelectedDate;
        String? newSelectedTimeSlot;

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
                          newSelectedDate = pickedDate;
                        });
                      },
                      child: Text(
                        newSelectedDate != null
                            ? newSelectedDate.toString().split(' ')[0]
                            : selectedDate,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Time Slot Picker
                    DropdownButton<String>(
                      value: newSelectedTimeSlot ?? selectedTimeSlot,
                      hint: Text('Select Time Slot'),
                      onChanged: (String? newValue) {
                        setState(() {
                          newSelectedTimeSlot = newValue;
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
                      onPressed: () {
                        if (newSelectedDate != null) {
                          setState(() {
                            selectedDate = newSelectedDate.toString().split(' ')[0];
                          });
                        }
                        if (newSelectedTimeSlot != null) {
                          setState(() {
                            selectedTimeSlot = newSelectedTimeSlot!;
                          });
                        }
                        Navigator.pop(context);
                      },
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
