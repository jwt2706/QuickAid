import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("Hello"),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("working"),
        tooltip: 'voice',
        child: Icon(Icons.),
      ),
    );
  }
}
