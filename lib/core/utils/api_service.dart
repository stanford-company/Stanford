import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api/'; // For Android emulator

  Future<Map<String, dynamic>> post(
      String endpoint,
      Map<String, dynamic> body, {
        Map<String, String>? headers,
      }) async {
    try {
      print('Making request to: ${baseUrl + endpoint}'); // Debug print

      final response = await http.post(
        Uri.parse(baseUrl + endpoint),
        headers: {
          'Content-Type': 'application/json',
          ...?headers, // Merge additional headers
        },
        body: jsonEncode(body),
      ).timeout(Duration(seconds: 10));

      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }else if(response.statusCode == 404){
        print("tauowdhfeukfhhhhhhhhhhhhhhhhhhhhhuu");
        return jsonDecode("ewwwwwwwwwwwwwwwwwwwwwwwww");
      } else {
        throw Exception('Server responded with status ${response.statusCode}');
      }
    } catch (e) {
      print('Network error details: $e'); // Detailed error logging
      if (e.toString().contains('Connection refused')) {
        throw Exception('Could not connect to server. Please check your network.');
      } else if (e.toString().contains('Failed host lookup')) {
        throw Exception('Server unavailable. Please try again later.');
      } else {
        throw Exception('Network error occurred. Please check your connection.');
      }
    }
  }
}