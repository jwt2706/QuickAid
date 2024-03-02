import 'package:flutter/material.dart';
import 'package:quickaid/resources/emergency_contact.dart';

class EmergencyContactList extends StatelessWidget {
  final List<EmergencyContact> emergencyContacts;

  const EmergencyContactList({super.key, required this.emergencyContacts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: emergencyContacts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(emergencyContacts[index].name),
          subtitle: Text('Email: ${emergencyContacts[index].email}'),
        );
      },
    );
  }
}
