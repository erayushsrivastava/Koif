import 'package:flutter/material.dart';

class PhoneLoginScreen extends StatefulWidget {
  @override
  _PhoneLoginScreenState createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController countryCodeController = TextEditingController(text: "+");
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // User Icon Section
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.phone_android,
                    size: 72,
                    color: Colors.grey[700],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Login with Phone',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Enter your phone number to continue.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Country Code and Phone Number Input
            Row(
              children: [
                // Country Code Input
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: countryCodeController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Country Code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // Phone Number Input
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Create Password Input
            TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Enter the Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            SizedBox(height: 24),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                String countryCode = countryCodeController.text;
                String phoneNumber = phoneNumberController.text;
                String password = passwordController.text;
                print('Country Code: $countryCode');
                print('Phone Number: $phoneNumber');
                print('Password: $password');
                // Add your submit logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
