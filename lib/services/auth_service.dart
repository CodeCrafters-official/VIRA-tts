import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String baseUrl = "http://127.0.0.1:5000";  // Flask server URL

  static Future<bool> signupUser(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/signup"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"name": name, "email": email, "password": password}),
    );

    if (response.statusCode == 201) {
      return true;  // Success
    } else {
      final message = json.decode(response.body)["message"];
      print(message);
      return false;  // Error
    }
  }

  static Future<bool> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return true;  // Success
    } else {
      final message = json.decode(response.body)["message"];
      print(message);
      return false;  // Error
    }
  }
}
