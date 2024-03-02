import 'package:flutter/material.dart';
import 'package:quickaid/resources/local_storage.dart';

class ApiHandler extends StatefulWidget {
  final String text;
  const ApiHandler({super.key, required this.text});

  @override
  State<ApiHandler> createState() => _ApiHandlerState();
}

class _ApiHandlerState extends State<ApiHandler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Text(widget.text),
    );
  }
}
