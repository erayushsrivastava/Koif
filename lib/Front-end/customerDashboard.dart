import 'package:flutter/material.dart';
import 'package:koif/Front-end/stripe.dart';
import 'globalNavigatorBar.dart'; // Import the global navigation bar
import 'AtSalon.dart';
import 'AtHome.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared preferences

class CustomerDashboard extends StatefulWidget {
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  String userName = "User"; // Default name
  
  // Method to load user name from shared preferences
  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedName = prefs.getString('userName');
    
    setState(() {
      userName = storedName ?? "User"; // Use "User" if no name is stored
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserName(); // Load the name when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4), // Background color for the screen
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 155, 155, 155), // AppBar background
        elevation: 190, // Shadow
        automaticallyImplyLeading: false, // Disable the back arrow
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
                  'Good Morning, $userName', // Display dynamically loaded name
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // At Salon Section inside a shadow box
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // More visible shadow
                      blurRadius: 20,
                      spreadRadius: 10,
                      offset: Offset(0, 10), // Shadow position
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Center the content
                  children: [
                    Text(
                      'At Salon',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Schedule your salon service appointments.',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(height: 15),
                    // Center the image
                    Center(
                      child: Image.asset(
                        'assets/images/salon_image.png', // Placeholder for salon image
                        height: 300, // Increased height
                        width: 250, // Increased width
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 30), // Space before the button
                    // Center the button
                    Center(
                      child: ElevatedButton(
                        onPressed:  ()  {
                        
                          // Add your booking functionality here
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AtSalon()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(11, 37, 69, 1),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadowColor: Colors.black, // Add black shadow to the button
                          elevation: 10, // Increase elevation for shadow effect
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Adjust the size of the button
                          children: [
                            Text(
                              'Book Now',
                              style: TextStyle(color: Colors.white), // White text color
                            ),
                            SizedBox(width: 5), // Space between text and arrow
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // At Home Section inside a shadow box
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // More visible shadow
                      blurRadius: 20,
                      spreadRadius: 10,
                      offset: Offset(0, 10), // Shadow position
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Center the content
                  children: [
                    Text(
                      'At Home',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Book your hairstylist or beautician to come to your door.',
                      style: TextStyle(color: Colors.black, fontSize: 16), // Changed to black
                    ),
                    SizedBox(height: 16),
                    // Center the image
                    Center(
                      child: Image.asset(
                        'assets/images/home.png', // Placeholder for home service image
                        height: 250, // Increased height
                        width: 200, // Increased width
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 30), // Space before the button
                    // Center the button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your home service booking functionality here
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AtHome()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(11, 37, 69, 1),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadowColor: Colors.black, // Add black shadow to the button
                          elevation: 10, // Increase elevation for shadow effect
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Adjust the size of the button
                          children: [
                            Text(
                              'Book Now',
                              style: TextStyle(color: Colors.white), // White text color
                            ),
                            SizedBox(width: 5), // Space between text and arrow
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GlobalNavigationBar(selectedIndex: 0), // Pass the selected tab index (0 for Home)
    );
  }
}
