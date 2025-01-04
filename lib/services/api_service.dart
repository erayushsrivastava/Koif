import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http; // Import the http package
import 'package:koif/constants/constants.dart'; // Import the constants file

// Function to fetch nearby salons
Future<List<dynamic>> fetchNearbySalons(double latitude, double longitude) async {
  const String apiUrl =
      "https://4gvrqhysv8.execute-api.eu-west-3.amazonaws.com/dev/nearby-salons";

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "latitude": latitude,
      "longitude": longitude,
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data["data"];
  } else {
    throw Exception("Failed to fetch nearby salons");
  }
}

// Function to upload shop details
Future<void> uploadShopDetails(Map<String, dynamic> shopDetails) async {
  final url = Uri.parse(uploadShopDetailsEndpoint); // Use the constant from constants.dart

  try {
    // Make the POST request
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: jsonEncode(shopDetails), // Convert the shopDetails map to a JSON string
    );

    // Handle the response
    if (response.statusCode == 200) {
      print('Shop details uploaded successfully!');
    } else {
      print('Failed to upload shop details. Error: ${response.body}');
    }
  } catch (e) {
    // Handle any errors that occur during the request
    print('An error occurred: $e');
  }
}
