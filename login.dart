import 'package:flutter/material.dart';
import 'package:koif/Front-end/register.dart';
import 'package:koif/Front-end/phone_login.dart';
import 'package:koif/Front-end/customerDashboard.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    Icons.person_outline,
                    size: 72,
                    color: Colors.grey[700],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Welcome back',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please enter your details to login.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Email Input
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'hello@domain.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Password Input
            TextField(
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
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
            SizedBox(height: 8),

            // Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Handle Forgot Password
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),

            // Remember Me and Login Button
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                Text('Remember me')
              ],
            ),

            // Login Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerDashboard(),
      ),
    );

                // Handle Login
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),

            // OR Divider
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[400])),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey[400])),
              ],
            ),
            SizedBox(height: 16),

            // Social Login Buttons
            ElevatedButton.icon(
              onPressed: () {
                // Handle Login with Google
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.grey[300]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Image.asset(
                'assets/images/googleLogo.png',
                height: 24,
                width: 24,
              ),
              label: Text(
                'Login with Google',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {
                // Navigate to PhoneLoginScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhoneLoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.grey[300]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(
                Icons.phone,
                color: Colors.black,
              ),
              label: Text(
                'Login with Phone',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 32),

            // Register/Signup Flow
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account? '),
                GestureDetector(
                  onTap: () {
                    // Navigate to Register/Sign Up
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
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
