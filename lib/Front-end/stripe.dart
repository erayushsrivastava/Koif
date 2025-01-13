

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class StripeService {
  static const String _baseUrl = 'http://192.168.31.245:5000/api/payment/create-payment';
  
  static Future<void> makePayment({
    required double amount,
    required String currency,
  }) async {
    try {
      print("Attempting payment for amount: $amount");
      
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'amount': (amount * 100).toInt(),
          'currency': currency,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final paymentUrl = json.decode(response.body)['url'];
        print('Payment URL: $paymentUrl');
        
        // Updated URL launching code
        if (!await launchUrl(
          Uri.parse(paymentUrl),
          mode: LaunchMode.externalApplication,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
          
        )) {
          throw Exception('Could not launch Stripe payment page');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Payment error: $e');
      throw Exception('Payment failed: $e');
    }
  }
}

static Future<void> updateSatus() async {
  try {
    final response = await http.get(
      Uri.parse('http://192.168.31.245:5000/api/payment/update-status'),
    );

    if (response.statusCode == 200) {
      print('Payment status updated successfully');
    } else {
      print('Failed to update payment status. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error updating payment status: $e');
  }
}