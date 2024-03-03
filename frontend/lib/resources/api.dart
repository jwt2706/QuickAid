import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  final String url;

  Api({required this.url});

  Future<String> sendTranscription(
      String transcriptionText, double long, double lat) async {
    print('$long $lat');
    final headers = {"Content-Type": "application/json"};
    final jsonBody = json
        .encode({"transcript": transcriptionText, "long": long, "lat": lat});

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final data = json.decode(response.body);
        return '${data['message']}';
        // return transcriptionText;
      } else {
        // If the server did not return a 200 OK response,
        // then return an error message
        return 'Failed to send transcription. Status code: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error sending transcription: $e';
    }
  }

  Future<dynamic> fetchData() async {
    try {
      final response = await http.get(Uri.parse(url));
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
        Uri.parse(url),
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
