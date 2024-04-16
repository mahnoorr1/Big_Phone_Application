import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateCustomer {
  final client = http.Client();
  static Map<String, String> headers = {
    'Authorization': 'Bearer [your secret key]',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  Future<Map<String, dynamic>> createCustomer() async {
    final String url = 'https://api.stripe.com/v1/customers';
    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {'description': 'new customer'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to register as a customer.';
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntents() async {
    final String url = 'https://api.stripe.com/v1/payment_intents';

    Map<String, dynamic> body = {
      'amount': '2000',
      'currency': 'jpy',
      'payment_method_types[]': 'card'
    };

    var response =
        await client.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to create PaymentIntents.';
    }
  }
}
