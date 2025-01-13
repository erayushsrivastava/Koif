// lib/BookingsBarberBuddies.dart
import 'package:flutter/material.dart';
import 'barberBuddiesNavBar.dart';

class BookingsBarberBuddies extends StatelessWidget {
  final List<Map<String, String>> acceptedJobs; // List to hold accepted job details

  BookingsBarberBuddies({required this.acceptedJobs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4),
      appBar: AppBar(
        backgroundColor: Color(0xFF8DA9C4),
        elevation: 0,
        title: Text('Bookings', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: acceptedJobs.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: acceptedJobs.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
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
                              acceptedJobs[index]['name'] ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Service: ${acceptedJobs[index]['services']}',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Scheduled Time: ${acceptedJobs[index]['time'] ?? ''}',
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Rate: ${acceptedJobs[index]['rate'] ?? ''}',
                          style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'Your booking information will appear here.',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
      bottomNavigationBar: BarberBuddiesNavBar(
        selectedIndex: 1, // Bookings selected
        acceptedJobs: acceptedJobs,
      ),
    );
  }
}
