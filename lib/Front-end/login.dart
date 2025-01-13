import 'package:flutter/material.dart';
import 'package:koif/Front-end/credentials.dart';
import 'package:koif/Front-end/customerDashboard.dart'; // Import the CustomerDashboard
//import 'package:koif/main.dart'; // Import your main.dart to access the signInWithGoogle function

class LoginScreen extends StatelessWidget {
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
            // Heading: "Login as Style Stars"
            Text(
              'Login as Style Stars',
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
                    textAlign: TextAlign.center, // Center aligned for better aesthetics
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
              width: double.infinity, // Make the button take full width
              height: 60, // Increase button height
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    //await signInWithGoogle(); // Call the Google login function
                    // Navigate to the customer dashboard after successful login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerDashboard(),
                      ),
                    );
                  } catch (e) {
                    print('Error during Google Sign-In: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0B2545), // Button color changed to #0B2545
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black87, // Darker shadow color for more visibility
                  elevation: 30, // Increase shadow elevation to make it more prominent
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/googleLogo.png', // Path to your Google logo image
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
              width: double.infinity, // Make the button take full width
              height: 60, // Increase button height
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to CustomerDashboard when the "Continue with Phone" button is pressed
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CredentialsScreen()),
                  );
                },
                icon: Icon(Icons.phone, color: Colors.white),
                label: Text(
                  'Continue with Phone',
                  style: TextStyle(
                    color: Colors.white, // Ensure the text color is white
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0B2545), // Button color changed to #0B2545
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black87, // Darker shadow color for more visibility
                  elevation: 30, // Increase shadow elevation to make it more prominent
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
                    // Handle log in action
                    print("Log in tapped");
                    // Navigate to LoginPage or handle login action
                  },
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.blue, // Set hyperlink color to blue
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.underline, // Underline the text for hyperlink effect
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

// // write code fro the login or signup screen
// import 'package:flutter/material.dart';
// import 'package:koif/Front-end/register.dart';
// import 'package:koif/Front-end/phone_login.dart';
// import 'package:koif/Front-end/customerDashboard.dart';
// import 'package:koif/Front-end/auth_service.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController; // Use `late` to ensure initialization
//   final AuthService _authService = AuthService(); // Instantiate AuthService
//   bool _obscurePassword = true;
//   String phoneNumber = ''; // Mobile number variable
//   String password = ''; // Password variable

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose(); // Dispose of the TabController
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.black,
//           labelColor: Colors.black,
//           unselectedLabelColor: Colors.grey,
//           tabs: [
//             Tab(text: 'Login'),
//             Tab(text: 'Sign Up'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           // Login Form
//           _buildLoginForm(),
//           // Signup Form (You can implement this later)
//           SignupForm(),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoginForm() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           TextField(
//             onChanged: (value) {
//               phoneNumber = value; // Update phone number
//             },
//             decoration: InputDecoration(
//               labelText: 'Mobile Number',
//               hintText: 'Enter your mobile number',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//           TextField(
//             onChanged: (value) {
//               password = value; // Update password
//             },
//             obscureText: _obscurePassword,
//             decoration: InputDecoration(
//               labelText: 'Password',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () async {
//               if (phoneNumber.isEmpty || password.isEmpty) {
//                 // Show an error message
//                 print('Phone number and password cannot be empty');
//                 return;
//               }
//               bool success = await _authService.signIn(phoneNumber, password);
//               if (success) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => CustomerDashboard()),
//                 );
//               } else {
//                 // Handle login failure (show an error message)
//                 print('Login failed. Please check your credentials.');
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black,
//               padding: EdgeInsets.symmetric(vertical: 16),
//             ),
//             child: Text('Login', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SignupForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Center(
//             child: Column(
//               children: [
//                 Icon(
//                   Icons.person_add,
//                   size: 72,
//                   color: Colors.grey[700],
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Create an account',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Please enter your details to sign up.',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 32),
//           TextField(
//             decoration: InputDecoration(
//               labelText: 'Email',
//               hintText: 'hello@domain.com',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//           TextField(
//             obscureText: true,
//             decoration: InputDecoration(
//               labelText: 'Password',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               // Handle Signup
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black,
//               padding: EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Text(
//               'Sign Up',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
