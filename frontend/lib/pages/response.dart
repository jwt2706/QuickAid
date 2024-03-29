import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickaid/resources/api.dart';
import 'package:quickaid/resources/local_storage.dart';
import 'package:quickaid/resources/location.dart';
import 'package:quickaid/resources/text_to_speach.dart';
import 'package:quickaid/widget/text_container.dart';

class ApiHandler extends StatefulWidget {
  final String text;
  const ApiHandler({super.key, required this.text});

  @override
  State<ApiHandler> createState() => _ApiHandlerState();
}

class _ApiHandlerState extends State<ApiHandler> {
  Api call = Api(url: "https://quickaid-server.vercel.app/transcript");
  String _text = "Waiting for the server...";
  GeolocationHandler location = GeolocationHandler();
  double lat = 0, long = 0;

  Future<void> _getData() async {
    await _fetchLocation();
    try {
      String responseText =
          await call.sendTranscription(widget.text, long, lat);
      setState(() {
        _text = responseText;
      });
    } catch (e) {
      setState(() {
        _text = "Failed to fetch data from the server: $e";
      });
    }
    await speakText();
  }

  Future<void> _fetchLocation() async {
    try {
      Position position = await location.getCurrentLocation();
      long = position.longitude;
      lat = position.latitude;
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> speakText() async {
    SpeakText speak = SpeakText(textToSpeak: _text);
    speak.initializeTTS();
    speak.speak();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: const Text(
            'Quickaid',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          leading: const Icon(
            Icons.local_hospital,
            size: 40, // Increases the icon size
            color: Colors.white, // Changes the icon color to red
          ),
        ),
        body: TextHolder(text: _text),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(
                context); // This line navigates back to the previous screen
          },
          child: Icon(Icons.home), // This is the home icon
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .endFloat, // This line positions the FAB at the bottom right
      ),
    );
  }
}
