import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  final String serverUrl;

  Api({required this.serverUrl});

  Future<dynamic> fetchData() async {
    try {
      final response = await http.get(Uri.parse(serverUrl));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle any exceptions thrown during the request.
      throw Exception('Error occurred: $e');
    }
  }

  Future<dynamic> sendData(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(serverUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to send data');
      }
    } catch (e) {
      // Handle any exceptions thrown during the request.
      throw Exception('Error occurred: $e');
    }
  }
}
