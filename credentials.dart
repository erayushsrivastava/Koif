import 'package:flutter/material.dart';

class CredentialsScreen extends StatelessWidget {
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

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
            // OTP Input
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
                onPressed: () {
                  // Handle OTP verification and navigation
                  print('Country Code: ${countryCodeController.text}');
                  print('Phone Number: ${phoneNumberController.text}');
                  print('OTP: ${otpController.text}');
                  // Add your logic for OTP verification here
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
