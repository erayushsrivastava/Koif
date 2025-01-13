import 'package:flutter/material.dart';
import 'package:koif/services/api_service.dart'; // Import the API service function
import 'globalNavigatorBar.dart'; // Import the global navigation bar
import 'InsideSalon.dart'; // Import the InsideSalon screen
import 'package:shared_preferences/shared_preferences.dart';

class AtSalon extends StatefulWidget {
  @override
  _AtSalonState createState() => _AtSalonState();
}

class _AtSalonState extends State<AtSalon> {
  List<dynamic> salons = []; // List to store the fetched salon data
  bool isLoading = true; // Show a loading indicator while fetching data
  String userName = "User"; // Default name
  String userLocation = "Location"; // Default location

  @override
  void initState() {
    super.initState();
    fetchSalons(); // Fetch data when the widget is initialized
  }

  // Function to fetch salons and update the UI
  Future<void> fetchSalons() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedName = prefs.getString('userName');
    String? storedLocation = prefs.getString('userLocation');

    if (storedName != null) {
      setState(() {
        userName = storedName; // Update userName if available
      });
    }

    if (storedLocation != null) {
      setState(() {
        userLocation = storedLocation; // Update userLocation if available
      });
    }

    try {
      final result = await fetchNearbySalons(40.7128, -74.0060); // Example coordinates (latitude & longitude)
      print(result);
      setState(() {
        salons = result; // Update the salons list
        isLoading = false; // Stop loading indicator
      });
    } catch (e) {
      print("Error fetching salons: $e");
      setState(() {
        isLoading = false; // Stop loading even if an error occurs
      });
    }
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
                  'Good, $userName',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  userLocation,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black), // Notification icon
            onPressed: () {
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show a loading indicator
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // At Salon Title
                Text(
                  'At Salon',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome to the salon section, here you can search to grab services and book appointments for beautification.',
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
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
                // Nearby Salons Title
                Center(
                  child: Text(
                    'Nearby Salons',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                // Nearby Salons List
                salons.isEmpty
                    ? Center(
                        child: Text(
                          'No nearby salons found',
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: salons.length,
                        itemBuilder: (context, index) {
                          final salon = salons[index];
                          return _buildNearbySalonCard(
                            context,
                            salon["name"],
                            salon["address"],
                            'assets/images/salon1.webp', // Placeholder image
                          );
                        },
                      ),
              ],
            ),
      bottomNavigationBar: GlobalNavigationBar(selectedIndex: 0), // Global Navigation Bar
    );
  }

  // Helper function to build service category item with increased image size
  Widget _buildServiceCategory(String title, String imagePath) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: 70, // Reduced height of the image
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

  // Helper function to build a nearby salon card
  Widget _buildNearbySalonCard(BuildContext context, String salonName,
      String location, String imagePath) {
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
            // Salon image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            // Salon details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    salonName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    location,
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(height: 10),
                  // Book Now button
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InsideSalon()),
                      );
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
