import 'package:flutter/material.dart';
import 'globalNavigatorBar.dart'; // Import the global navigation bar
import 'InsideBarberService.dart'; // Import the InsideSalon screen, or any other relevant page
import 'package:shared_preferences/shared_preferences.dart';

class AtHome extends StatefulWidget {
  @override
  _AtHomeState createState() => _AtHomeState();
}

class _AtHomeState extends State<AtHome> {
  String userName = "User"; // Default name
  String userLocation = "Location"; // Default location

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Fetch user data from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedName = prefs.getString('userName');
    String? storedLocation = prefs.getString('userLocation');

    setState(() {
      userName = storedName ?? "User"; // Use default if no name is stored
      userLocation = storedLocation ?? "Location"; // Use default if no location is stored
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
                  'Good, $userName', // Display dynamically fetched user name
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  userLocation, // Display dynamically fetched location
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
          // At Home Title
          Text(
            'At Home',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            'Welcome to the home services section, where you can book a freelance barber for grooming at your place.',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          SizedBox(height: 20),
          // Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              textAlign: TextAlign.center, // Center the text inside the search box
              decoration: InputDecoration(
                hintText: 'Search here',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 30),
          // Service Categories Title
          Center(
            child: Text(
              'Service Categories',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          SizedBox(height: 30),
          // Service Categories Grid
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // Prevent scrolling inside the GridView
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildServiceCategory('Hair Cut', 'assets/images/hair_cut.png'),
              _buildServiceCategory('Beard', 'assets/images/beard.png'),
              _buildServiceCategory('Spa', 'assets/images/spa.png'),
              _buildServiceCategory('Skin Care', 'assets/images/skin_care.png'),
              _buildServiceCategory('Hair Color', 'assets/images/hair_color.png'),
              _buildServiceCategory('Mani and Pedi', 'assets/images/mani_pedi.png'),
            ],
          ),
          SizedBox(height: 30),
          // Nearby Barbers Title
          Center(
            child: Text(
              'Nearby Barbers',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          SizedBox(height: 20),
          // Nearby Freelance Barbers List (now with User Icons)
          _buildNearbyBarberCard(
            context,
            'John Doe',
            'Freelancer Barber, 5★',
          ),
          SizedBox(height: 20),
          _buildNearbyBarberCard(
            context,
            'Jane Smith',
            'Freelancer Barber, 4.8★',
          ),
          SizedBox(height: 20),
          _buildNearbyBarberCard(
            context,
            'Michael Lee',
            'Freelancer Barber, 4.9★',
          ),
          SizedBox(height: 20),
          _buildNearbyBarberCard(
            context,
            'Emma Watson',
            'Freelancer Barber, 4.7★',
          ),
        ],
      ),
      bottomNavigationBar: GlobalNavigationBar(selectedIndex: 0), // Global Navigation Bar
    );
  }

  // Helper function to build service category item with adjusted image size
  Widget _buildServiceCategory(String title, String imagePath) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: 70, // Adjusted height for icons
          fit: BoxFit.cover,
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  // Helper function to build a nearby freelance barber card with User Icon
  Widget _buildNearbyBarberCard(BuildContext context, String barberName, String rating) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 5), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // User Icon instead of barber image
            CircleAvatar(
              radius: 40, // Adjusted size of the icon
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.black,
              ), // User Icon to represent the barber
            ),
            SizedBox(width: 15),
            // Barber details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    barberName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    rating,
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(height: 10),
                  // Book Now button for home services
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to InsideSalon screen (or another page for freelance services)
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InsideBarberServices(barberName: barberName)));
                    },
                    label: Text(
                      'Book Now',
                      style: TextStyle(color: Colors.white), // White text color
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
