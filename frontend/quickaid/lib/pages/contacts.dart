import 'package:flutter/material.dart';
import 'package:quickaid/resources/emergency_contact.dart';
import 'package:quickaid/widget/emergency_contact_list.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<EmergencyContact> emergencyContacts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text(
          'Emergency Contacts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        actions: [
        IconButton(
          icon: const Icon(
            Icons.add,
            size: 40, // Increases the icon size
            color: Colors.white, // Changes the icon color to white
          ),
          onPressed: () {
            setState(() {
              emergencyContacts.add(EmergencyContact("dan", "...", "d@gmail.com", Relationship.friend));
            });
          },
        ),
      ],
      ),
      body: EmergencyContactList(emergencyContacts: emergencyContacts),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
    );
  }
}
