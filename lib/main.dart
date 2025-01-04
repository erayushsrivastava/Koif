import 'package:flutter/material.dart';
import 'package:koif/Front-end/splashscreen.dart';
import 'package:koif/services/api_service.dart'; // Import the API service file for uploadShopDetails

//Amplify-related imports
//import 'package:amplify_flutter/amplify.dart';
//import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
//import 'amplifyconfiguration.dart'; // Import your Amplify configuration file

void main() {
  //WidgetsFlutterBinding.ensureInitialized(); // Ensures proper initialization of bindings in Flutter
  //configureAmplify(); // Initialize Amplify
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KOIF App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SplashScreen(), // Set SplashScreen as the first screen
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      //onGenerateInitialRoutes: RouteGenerator().generateRoute,
    );
  }
}

// Amplify initialization function
/*void configureAmplify() async {
  try {
    // Add the Cognito Auth plugin
    await Amplify.addPlugin(AmplifyAuthCognito());

    // Configure Amplify using the amplifyconfiguration.dart file
    await Amplify.configure(amplifyconfig);

    print('Amplify configured successfully');
  } catch (e) {
    // Handle errors during initialization
    print('An error occurred configuring Amplify: $e');
  }
}

// Example function for Google sign-in
Future<void> signInWithGoogle() async {
  try {
    SignInResult result =
        await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
    if (result.isSignedIn) {
      print('Google sign-in successful');
    } else {
      print('Google sign-in failed');
    }
  } catch (e) {
    print('Error signing in with Google: $e');
  }
}*/

// Test API service call
void testApiService() {
  final shopDetails = {
    "shopName": "Salon Bliss",
    "location": "123 Main Street",
    "contact": "123-456-7890",
  };

  uploadShopDetails(shopDetails);
}
