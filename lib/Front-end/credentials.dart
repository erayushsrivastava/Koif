import 'package:flutter/material.dart';
import 'auth_service.dart'; // Assuming you have the AuthService in a separate file
import 'package:koif/Front-end/customerDashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredentialsScreen extends StatelessWidget {
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController(); // Unused now

  final AuthService _authService = AuthService();  // Create an instance of the AuthService
// Save user data locally using SharedPreferences
  Future<void> saveUserData(String name, String location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setString('userLocation', location);
    print('User data saved: Name: $name, Location: $location');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4), // Background color similar to login.dart
      appBar: AppBar(
        backgroundColor: Color(0xFF0B2545), // Same app bar color as buttons
        elevation: 0,
        title: Text('Verify Your Phone'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40), // Space from the top
            // Heading: "Enter your Phone Details"
            Text(
              'Enter your Phone Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            // Country Code Input
            TextField(
              controller: countryCodeController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Country Code',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Color(0xFF0B2545), // Input field background color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.flag, color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            // Phone Number Input
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Color(0xFF0B2545),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.phone, color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            // OTP Input (Unused, removed OTP verification logic)
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'OTP',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Color(0xFF0B2545),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 30),
            // Continue Button
            SizedBox(
              width: double.infinity, // Full-width button
              height: 60,
              child: ElevatedButton(
                    onPressed: () async {
  final phoneNumber = countryCodeController.text + phoneNumberController.text;

  try {
    // Attempt to create the user
    bool isSuccess = await _authService.createUser(
      user_name: "Priyanka", // Default name
      email: "priyankasharma7694074441@gmail.com", // Default email
      phoneNumber: phoneNumber, // Passed as an argument
      address: "0.0,0.0", // Default geolocation
    );
    // Save name and location locally
        await saveUserData("Priyanka", "0.0,0.0");

    if (isSuccess) {
      print('User successfully created');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerDashboard(),
        ),
      );
      await _authService.confirmUser(phoneNumber);

    }
  } catch (e) {
    print('Error creating user: $e');
    // Handle specific exceptions
    if (e.toString().contains('UsernameExistsException')) {
      print('User already exists. Attempting to sign in...');
      try {
        bool isSignedIn = await _authService.signIn(
          phoneNumber, // Use phoneNumber or email for signing in
          'TemporaryPassword123!', // Use the temporary password
        );
                await saveUserData("Priyanka", "0.0,0.0");

        print('Sign-in result: $isSignedIn');
        print('isSignedIn: $phoneNumber');
        
        if (isSignedIn) {
          print('Sign-in successful');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerDashboard(),
            ),
          );
        } else {
           Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerDashboard(),
            ),
          );
          print('Error signing in user $e');
        }
      } catch (signInError) {
        print('Error during sign-in: $signInError');
      }
    } else {
      print('Error creating or signing in user: $e');
    }
  }
},

                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0B2545), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black87,
                  elevation: 30,
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
