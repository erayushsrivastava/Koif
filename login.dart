import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  bool showLoginWithGoogle = false;
  bool showLoginWithPhone = false;
  bool showSignUpWithGoogle = false;
  bool showSignUpWithPhone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Logo
                    height: 150,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Toggle between Login and Signup
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = true;
                      resetDropdownStates();
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        'LOG IN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isLogin ? Colors.orange : Colors.white70,
                        ),
                      ),
                      if (isLogin)
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          height: 3,
                          width: 60,
                          color: Colors.orange,
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = false;
                      resetDropdownStates();
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: !isLogin ? Colors.orange : Colors.white70,
                        ),
                      ),
                      if (!isLogin)
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          height: 3,
                          width: 60,
                          color: Colors.orange,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Login and Signup Sections
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (isLogin) ...[
                      // Login with Google
                      buildCustomExpansionTile(
                        title: 'Login with Google',
                        isExpanded: showLoginWithGoogle,
                        onExpansionChanged: (expanded) {
                          setState(() {
                            showLoginWithGoogle = expanded;
                          });
                        },
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // Login with Google functionality
                            },
                            child: Text(
                              "Login with Google",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      // Login with Phone
                      buildCustomExpansionTile(
                        title: 'Login with Phone',
                        isExpanded: showLoginWithPhone,
                        onExpansionChanged: (expanded) {
                          setState(() {
                            showLoginWithPhone = expanded;
                          });
                        },
                        children: [
                          customTextField(
                            labelText: "Phone Number",
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 10),
                          customTextField(
                            labelText: "OTP",
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // Login with Phone functionality
                            },
                            child: Text(
                              "Login with Phone",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      // Sign Up with Google
                      buildCustomExpansionTile(
                        title: 'Sign up with Google',
                        isExpanded: showSignUpWithGoogle,
                        onExpansionChanged: (expanded) {
                          setState(() {
                            showSignUpWithGoogle = expanded;
                          });
                        },
                        children: [
                          customTextField(
                            labelText: "Email Address",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 10),
                          customTextField(
                            labelText: "Full Name",
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 10),
                          customTextField(
                            labelText: "Create Password",
                            obscureText: true,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // Sign up with Google functionality
                            },
                            child: Text(
                              "Sign up with Google",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      // Sign Up with Phone
                      buildCustomExpansionTile(
                        title: 'Sign up with Phone',
                        isExpanded: showSignUpWithPhone,
                        onExpansionChanged: (expanded) {
                          setState(() {
                            showSignUpWithPhone = expanded;
                          });
                        },
                        children: [
                          customTextField(
                            labelText: "Name",
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 10),
                          customTextField(
                            labelText: "Phone Number",
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 10),
                          customTextField(
                            labelText: "OTP",
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // Sign up with Phone functionality
                            },
                            child: Text(
                              "Sign up with Phone",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to reset dropdown states
  void resetDropdownStates() {
    showLoginWithGoogle = false;
    showLoginWithPhone = false;
    showSignUpWithGoogle = false;
    showSignUpWithPhone = false;
  }

  // Custom ExpansionTile builder
  Widget buildCustomExpansionTile({
    required String title,
    required bool isExpanded,
    required Function(bool) onExpansionChanged,
    required List<Widget> children,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        children: children,
        onExpansionChanged: onExpansionChanged,
        trailing: Icon(
          isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: Colors.orange,
        ),
      ),
    );
  }

  // Custom TextField builder
  Widget customTextField({
    required String labelText,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
