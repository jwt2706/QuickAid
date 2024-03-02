import 'package:flutter/material.dart';

class Instructions extends StatefulWidget {
  const Instructions({super.key});

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  final List<String> instructions = [
    "Ensure the device is charged.",
    "Connect to a stable Wi-Fi network.",
    "Log in with your credentials.",
    "Update the app to the latest version.",
    "Read through the user guide carefully.",
    "Contact support if you encounter any issues.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text(
          'Instructions',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: instructions.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 7, // Adds a slight shadow to each instruction card
              margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor, // Customize as needed
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  instructions[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text("Step ${index + 1}"),
              ),
            );
          },
        ),
      ),
    );
  }
}
