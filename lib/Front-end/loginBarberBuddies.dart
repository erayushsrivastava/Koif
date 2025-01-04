import 'package:flutter/material.dart';
import 'barberBuddiesDashboard.dart'; // Import the BarberBuddiesDashboard

class LoginBarberBuddies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4), // Background color similar to the image
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40), // Space from the top
            // Heading: "Login as Barber Buddies"
            Text(
              'Login as Barber Buddies',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30), // Space before logo
            // Logo Section
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Placeholder for the KOIF logo
                    height: 250,
                    width: 343, // Adjust as necessary
                  ),
                  SizedBox(height: 20),
                  // Tagline
                  Text(
                    'Feel Beautiful, Be Confident\nUnleash Your Inner Glow',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Subtitle
                  Text(
                    'Create a profile, follow other accounts,\nmake your own Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(179, 18, 16, 37),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50), // Space before the buttons
            // Continue with Google Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to BarberBuddiesDashboard when the "Continue with Google" button is pressed
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BarberBuddiesDashboard()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0B2545),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black87,
                  elevation: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/googleLogo.png', // Path to Google logo image
                      height: 40,
                      width: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Continue with Google',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Continue with Phone Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to BarberBuddiesDashboard when the "Continue with Phone" button is pressed
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BarberBuddiesDashboard()),
                  );
                },
                icon: Icon(Icons.phone, color: Colors.white),
                label: Text(
                  'Continue with Phone',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0B2545),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black87,
                  elevation: 30,
                ),
              ),
            ),
            SizedBox(height: 80),
            // Terms of Service and Privacy Policy
            Text.rich(
              TextSpan(
                text: 'By continuing, you agree to our ',
                style: TextStyle(color: Colors.white70, fontSize: 12),
                children: [
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(text: ' and acknowledge that you have read our'),
                  TextSpan(
                    text: ' Privacy Policy',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: ' to learn how we collect, use and share your data.',
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            // Already have an account? Log in
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                // Make "Log in" behave like a hyperlink
                GestureDetector(
                  onTap: () {
                    print("Log in tapped");
                    // Implement your login redirection if needed
                  },
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
