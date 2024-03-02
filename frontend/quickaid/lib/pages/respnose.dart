import 'package:flutter/material.dart';
import 'package:quickaid/resources/api.dart';
import 'package:quickaid/resources/local_storage.dart';
import 'package:quickaid/widget/text_container.dart';

class ApiHandler extends StatefulWidget {
  final String text;
  const ApiHandler({super.key, required this.text});

  @override
  State<ApiHandler> createState() => _ApiHandlerState();
}

class _ApiHandlerState extends State<ApiHandler> {
  Api call =
      Api(url: "https://vercel-test-beta-sable-67.vercel.app/transcript");
  String _text = "Waiting for the server...";

  Future<void> _getData() async {
    try {
      String responseText = await call.sendTranscription(widget.text);
      setState(() {
        _text = responseText;
      });
    } catch (e) {
      setState(() {
        _text = "Failed to fetch data from the server: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getData(); // Asynchronously fetch the data when the widget is initialized
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
      ),
    );
  }
}
