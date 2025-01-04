import 'package:flutter/material.dart';
import 'globalNavigatorBar.dart'; // Assuming this is your global navigation bar widget

class ConfirmationAtHome extends StatefulWidget {
  final Map<String, int> selectedServices;
  final String barberName;
  final String bookingDate;
  final String bookingTime;

  ConfirmationAtHome({
    required this.selectedServices,
    required this.barberName,
    required this.bookingDate,
    required this.bookingTime,
  });

  @override
  _ConfirmationAtHomeState createState() => _ConfirmationAtHomeState();
}

class _ConfirmationAtHomeState extends State<ConfirmationAtHome> {
  late Map<String, int> _editableServices;
  late String _editableDate;
  late String _editableTime;

  @override
  void initState() {
    super.initState();
    // Initialize with selected services and date/time
    _editableServices = Map.from(widget.selectedServices);
    _editableDate = widget.bookingDate;
    _editableTime = widget.bookingTime;
  }

  @override
  Widget build(BuildContext context) {
    // Filter out services that have a count of 0
    final filteredServices = Map.fromEntries(
      _editableServices.entries.where((entry) => entry.value > 0),
    );

    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4), // Light blue background
      appBar: AppBar(
        backgroundColor: Color(0xFF8DA9C4),
        elevation: 0,
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Barber profile picture
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 80, color: Colors.black),
            ),
          ),
          SizedBox(height: 20),
          // Barber name
          Text(
            widget.barberName,
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
          // Services Section
          Text(
            'Services',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 15),
          // Show only selected services with space between cards
          ...filteredServices.keys.map((serviceName) {
            return Column(
              children: [
                _buildEditableServiceCard(serviceName, filteredServices[serviceName]!),
                SizedBox(height: 15), // Add space between each service card
              ],
            );
          }).toList(),
          SizedBox(height: 20),
          // Booking date and time
          Text(
            'Booking Date & Time:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () => _editDateTime(context), // Allow editing of date and time
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$_editableDate, $_editableTime',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Icon(Icons.edit, color: Colors.black54), // Edit icon
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GlobalNavigationBar(selectedIndex: 0), // Add Global Navigation Bar
    );
  }

  // Editable service card to allow changing quantities
  Widget _buildEditableServiceCard(String serviceName, int count) {
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
                '€${count * 50}', // Assume each service costs €50
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

  // Method to increment service count
  void _incrementService(String serviceName) {
    setState(() {
      _editableServices[serviceName] = (_editableServices[serviceName] ?? 0) + 1;
    });
  }

  // Method to decrement service count
  void _decrementService(String serviceName) {
    setState(() {
      if ((_editableServices[serviceName] ?? 0) > 0) {
        _editableServices[serviceName] = (_editableServices[serviceName] ?? 0) - 1;
      }
    });
  }

  // Method to edit date and time
  void _editDateTime(BuildContext context) {
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
                height: MediaQuery.of(context).size.height * 0.4,
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
                            : _editableDate,
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
                              setState(() {
                                _editableDate = selectedDate!.toString().split(' ')[0];
                                _editableTime = selectedTimeSlot!;
                              });
                              Navigator.pop(context);
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
