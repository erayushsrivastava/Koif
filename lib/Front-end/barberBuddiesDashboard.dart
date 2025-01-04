// lib/barberBuddiesDashboard.dart
import 'package:flutter/material.dart';
import 'barberBuddiesNavBar.dart';

class BarberBuddiesDashboard extends StatefulWidget {
  @override
  _BarberBuddiesDashboardState createState() => _BarberBuddiesDashboardState();
}

class _BarberBuddiesDashboardState extends State<BarberBuddiesDashboard> {
  bool isOnline = false;
  Map<int, String> jobStatus = {};
  List<Map<String, String>> acceptedJobs = [];
  String userName = 'John Doe'; // Replace with dynamic user name if needed

  final List<Map<String, String>> jobRequests = [
    {
      'type': 'customer',
      'name': 'John Doe',
      'services': 'Haircut, Beard Trim, Spa Treatment',
      'time': 'Today, 2:00 PM',
      'rate': '\$30',
    },
    {
      'type': 'customer',
      'name': 'Sarah Williams',
      'services': 'Hair Color, Mani-Pedi',
      'time': 'Tomorrow, 11:00 AM',
      'rate': '\$50',
    },
    {
      'type': 'shop',
      'name': 'Star Salon',
      'services': 'Hair Stylist Needed',
      'image': 'assets/images/salon1.webp',
      'schedule': 'Mon-Fri, 10:00 AM - 6:00 PM',
      'rate': '\$25/hr',
    },
    {
      'type': 'shop',
      'name': 'Elite Cuts',
      'services': 'Nail Technician Needed',
      'image': 'assets/images/salon2.jpeg',
      'schedule': 'Sat-Sun, 9:00 AM - 5:00 PM',
      'rate': '\$20/hr',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4),
      appBar: AppBar(
        backgroundColor: Color(0xFF8DA9C4),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'Hi, $userName',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Text(
                isOnline ? 'Online' : 'Offline',
                style: TextStyle(color: isOnline ? Colors.green : Colors.red),
              ),
              Switch(
                value: isOnline,
                onChanged: (value) {
                  setState(() {
                    isOnline = value;
                  });
                },
                activeColor: Colors.green,
                inactiveThumbColor: Colors.red,
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: jobRequests.length,
        itemBuilder: (context, index) {
          if (jobRequests[index]['type'] == 'customer') {
            return _buildCustomerRequestCard(index);
          } else {
            return _buildShopJobPostCard(index);
          }
        },
      ),
      bottomNavigationBar: BarberBuddiesNavBar(
        selectedIndex: 0,
        acceptedJobs: acceptedJobs,
      ),
    );
  }

  // Customer Job Request Card
  Widget _buildCustomerRequestCard(int index) {
    return Opacity(
      opacity: isOnline ? 1.0 : 0.5,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Text(
                    jobRequests[index]['name'] ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Services Requested: ${jobRequests[index]['services'] ?? ''}',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 5),
              Text(
                'Scheduled Time: ${jobRequests[index]['time'] ?? ''}',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 5),
              Text(
                'Rate Offered: ${jobRequests[index]['rate'] ?? ''}',
                style: TextStyle(fontSize: 14, color: Colors.blueAccent),
              ),
              SizedBox(height: 10),
              isOnline ? _buildActionButtons(index) : _buildInactiveLabel(),
            ],
          ),
        ),
      ),
    );
  }

  // Shop Job Post Card
  Widget _buildShopJobPostCard(int index) {
    return Opacity(
      opacity: isOnline ? 1.0 : 0.5,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(jobRequests[index]['image'] ?? ''),
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    jobRequests[index]['name'] ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Service Required: ${jobRequests[index]['services'] ?? ''}',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 5),
              Text(
                'Schedule: ${jobRequests[index]['schedule'] ?? ''}',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 5),
              Text(
                'Rate: ${jobRequests[index]['rate'] ?? ''}',
                style: TextStyle(fontSize: 14, color: Colors.blueAccent),
              ),
              SizedBox(height: 10),
              isOnline ? _buildActionButtons(index) : _buildInactiveLabel(),
            ],
          ),
        ),
      ),
    );
  }

  // Enhanced Accept and Reject Buttons
  Widget _buildActionButtons(int index) {
    bool isAccepted = jobStatus[index] == 'accepted';
    bool isRejected = jobStatus[index] == 'rejected';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isAccepted ? Colors.green : Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            shadowColor: Colors.black,
            elevation: 6,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: isRejected
              ? null
              : () {
                  setState(() {
                    jobStatus[index] = 'accepted';
                    acceptedJobs.add(jobRequests[index]);
                  });
                },
          child: Text(
            isAccepted ? 'Accepted' : 'Accept',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isRejected ? Colors.red : Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            shadowColor: Colors.black,
            elevation: 6,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: isAccepted
              ? null
              : () {
                  setState(() {
                    jobStatus[index] = 'rejected';
                  });
                },
          child: Text(
            isRejected ? 'Rejected' : 'Reject',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildInactiveLabel() {
    return Center(
      child: Text(
        'Inactive',
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
      ),
    );
  }
}
