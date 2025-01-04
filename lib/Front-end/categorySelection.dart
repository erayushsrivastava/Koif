import 'package:flutter/material.dart';
import 'login.dart'; // Import the login page for Style Stars
import 'loginShopOwner.dart'; // Import the login page for Salon Stars (Shop Owner)
import 'loginBarberBuddies.dart'; // Import the login page for Barber Buddies

class CategorySelectionScreen extends StatefulWidget {
  @override
  _CategorySelectionScreenState createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  String? selectedCategoryId; // This will store the selected category's identifier

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4), // Same background color
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30), // Space for the top margin
            // Header Section
            Text(
              'Create Account',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Welcome to the KOIF',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 50),
            // Avatar Image and Chair
            Center(
              child: Image.asset(
                'assets/images/avatar_chair.png', // Placeholder for the avatar and chair image
                height: 200, // Adjust the height as necessary
              ),
            ),
            SizedBox(height: 30),
            // Select Category Label
            Text(
              'Select Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            // Category Buttons
            CategoryButton(
              icon: Icons.person,
              title: 'Style Stars',
              description: 'Those who need services',
              selected: selectedCategoryId == 'style_stars', // Compare with identifier
              onTap: () {
                setState(() {
                  selectedCategoryId = 'style_stars'; // Set identifier for Style Stars
                });
              },
            ),
            SizedBox(height: 20),
            CategoryButton(
              icon: Icons.store,
              title: 'Salon Stars',
              description: 'Those who own shop',
              selected: selectedCategoryId == 'salon_stars', // Compare with identifier
              onTap: () {
                setState(() {
                  selectedCategoryId = 'salon_stars'; // Set identifier for Salon Stars
                });
              },
            ),
            SizedBox(height: 20),
            CategoryButton(
              icon: Icons.content_cut,
              title: 'Barber Buddies',
              description: 'Those who sell services',
              selected: selectedCategoryId == 'barber_buddies', // Compare with identifier
              onTap: () {
                setState(() {
                  selectedCategoryId = 'barber_buddies'; // Set identifier for Barber Buddies
                });
              },
            ),
            SizedBox(height: 20), // Add some space between the buttons and the text
            // Instruction Text
            Center(
              child: Text(
                'Once you are done selecting your profession, proceed by clicking on the next button',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF414040), // Set the text color to #414040
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(), // Push the Next button to the bottom
            // Next Button
            Center(
              child: ElevatedButton(
                onPressed: selectedCategoryId != null
                    ? () {
                        if (selectedCategoryId == 'style_stars') {
                          // Navigate to LoginScreen (Style Stars)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        } else if (selectedCategoryId == 'salon_stars') {
                          // Navigate to LoginShopOwner (Salon Stars)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginShopOwner(),
                            ),
                          );
                        } else if (selectedCategoryId == 'barber_buddies') {
                          // Navigate to LoginBarberBuddies (Barber Buddies)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginBarberBuddies(),
                            ),
                          );
                        }
                      }
                    : null, // Disable the button if no category is selected
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 60), // Bottom padding
          ],
        ),
      ),
    );
  }
}

// Custom Widget for Category Button
class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  CategoryButton({
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger the tap action when the button is pressed
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.black38, // Change color based on selection
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: selected ? Colors.purpleAccent : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
