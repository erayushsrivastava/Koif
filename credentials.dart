import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CredentialsScreen extends StatefulWidget {
  @override
  _CredentialsScreenState createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final List<TextEditingController> otpControllers = List.generate(4, (_) => TextEditingController());

  bool isSendOtpButtonActive = false; // Initially, "Send OTP" button is inactive
  bool isContinueButtonActive = false; // To track if "Continue" button is active
  bool isTimerVisible = false; // Timer visibility
  int countdown = 60; // 1 minute in seconds
  Timer? timer;

  // Start the timer when the "Send OTP" button is pressed
  void startTimer() {
    setState(() {
      isSendOtpButtonActive = false; // Disable button
      isTimerVisible = true; // Show timer
    });
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel();
          isSendOtpButtonActive = true; // Re-enable the button after 1 minute
          isTimerVisible = false; // Hide timer
          countdown = 60; // Reset the timer
        }
      });
    });
  }

  // Format the countdown timer into MM:SS format
  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  // Check if all OTP fields are filled and valid
  void checkOtpValidity() {
    bool allFieldsFilled = otpControllers.every((controller) => controller.text.isNotEmpty);
    setState(() {
      isContinueButtonActive = allFieldsFilled;
    });
  }

  // Check if the phone number field is filled to enable "Send OTP" button
  void checkPhoneNumberValidity() {
    setState(() {
      isSendOtpButtonActive = phoneNumberController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Dispose of the timer when the widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4), // Original background color
      appBar: AppBar(
        backgroundColor: Color(0xFF0B2545), // App bar color
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Verify Your Phone',
          style: TextStyle(color: Colors.white), // Title color changed to white
        ),
        iconTheme: IconThemeData(color: Colors.white), // Back arrow color changed to white
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading
                    Center(
                      child: Text(
                        'Verify Your Phone',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B2545),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Full Name Field
                    Text(
                      'Full Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0B2545),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: fullNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        filled: true,
                        fillColor: Color(0xFFBCC6D6), // Lighter background color
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: TextStyle(color: Colors.black54), // Hint text color
                      ),
                      style: TextStyle(color: Colors.black), // Text color
                    ),
                    SizedBox(height: 20),

                    // Phone Details
                    Text(
                      'Phone Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0B2545),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        // Country Code Input
                        Container(
                          width: 100,
                          child: TextField(
                            controller: countryCodeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefix: Text(
                                '+',
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ), // "+" always visible
                              filled: true,
                              fillColor: Color(0xFFBCC6D6), // Lighter background color
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: TextStyle(color: Colors.black54),
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(width: 10),

                        // Phone Number Input
                        Expanded(
                          child: TextField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Enter your phone number',
                              filled: true,
                              fillColor: Color(0xFFBCC6D6), // Lighter background color
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: TextStyle(color: Colors.black54),
                            ),
                            style: TextStyle(color: Colors.black),
                            onChanged: (value) {
                              checkPhoneNumberValidity(); // Check phone number validity on input
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Send OTP Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isSendOtpButtonActive
                            ? () {
                                print('Country Code: ${countryCodeController.text}');
                                print('Phone Number: ${phoneNumberController.text}');
                                startTimer();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: isSendOtpButtonActive
                                ? LinearGradient(
                                    colors: [Color(0xFF4A148C), Color(0xFF880E4F)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: isSendOtpButtonActive ? null : Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              isSendOtpButtonActive
                                  ? 'Send OTP'
                                  : 'Enter phone number to send OTP',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Timer Section
                    if (isTimerVisible)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Resend OTP in ${formatTime(countdown)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF880E4F),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 20),

                    // OTP Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'OTP',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0B2545),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              4,
                              (index) => Container(
                                width: 50, // Box width
                                margin: EdgeInsets.symmetric(horizontal: 12), // Space between boxes
                                child: TextField(
                                  controller: otpControllers[index],
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    filled: true,
                                    fillColor: Color(0xFFBCC6D6), // Lighter background color
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintStyle: TextStyle(color: Colors.black54),
                                  ),
                                  style: TextStyle(color: Colors.black),
                                  onChanged: (value) {
                                    checkOtpValidity(); // Check OTP validity on each input
                                    if (value.length == 1 && index < 3) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isContinueButtonActive ? () {} : null,
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: isContinueButtonActive
                                ? LinearGradient(
                                    colors: [Color(0xFF4A148C), Color(0xFF880E4F)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: isContinueButtonActive ? null : Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Continue',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
