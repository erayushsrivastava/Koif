import 'package:flutter/material.dart';
import 'package:koif/Front-end/categorySelection.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _offset = 0.0; // To track the horizontal movement
  late AnimationController _animationController;
  bool _hideText = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4), // Background color
      body: Column(
        children: [
          Spacer(), // Push content down
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // KOIF Logo
                Image.asset(
                  'assets/images/logo.png', // Logo path
                  width: 250,
                  height: 250,
                ),
                SizedBox(height: 20),
                // Illustration Image
                Image.asset(
                  'assets/images/frontpage.png', // Illustration path
                  width: 300,
                  height: 300,
                ),
                SizedBox(height: 50),
                // Slogan Text
                Text(
                  "It's your time to shine with KOIF!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Spacer(flex: 2), // Push the slider area further down

          // Slider Area with Get Started Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Stack(
              children: [
                // The container that holds the shadow for the slider section
                Container(
                  width: screenWidth, // Full width of the screen
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Background track color
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26, // Shadow color
                        blurRadius: 8.0,
                        spreadRadius: 1.0,
                        offset: Offset(0, 4), // Shadow offset for depth effect
                      ),
                    ],
                  ),
                  child: Center(
                    // Fade out animation for the "Slide to Get Started" text
                    child: AnimatedOpacity(
                      opacity: _hideText ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        "Slide to Get Started", // Background text
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
                // The sliding button with its own shadow
                Positioned(
                  left: _offset, // Track the sliding offset
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        // Multiply the delta.dx by 2 for faster movement
                        _offset += details.delta.dx * 2;

                        if (_offset < 0) _offset = 0; // Restrict to left boundary

                        // Animate the placeholder text disappearance
                        if (_offset > 30 && !_hideText) {
                          _hideText = true;
                          _animationController.forward();
                        } else if (_offset <= 30 && _hideText) {
                          _hideText = false;
                          _animationController.reverse();
                        }

                        if (_offset > screenWidth - 100) {
                          // Restrict to right boundary and navigate when fully slid
                          _offset = screenWidth - 100;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategorySelectionScreen()),
                          );
                        }
                      });
                    },
                    child: Container(
                      width: 60, // Adjust the button size to be a circle
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple, // Button color
                        borderRadius: BorderRadius.circular(30.0), // Circle
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38, // Dark grey shadow for button
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: Offset(0, 5), // Shadow position
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '>', // Button text
                          style: TextStyle(
                            fontSize: 30, // Ensure the text is centered
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 60), // Add space at the bottom
        ],
      ),
    );
  }
}
