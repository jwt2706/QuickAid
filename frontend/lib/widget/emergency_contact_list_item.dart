import 'package:flutter/material.dart';
import 'package:quickaid/resources/emergency_contact.dart';

class EmergencyContactListItem extends StatelessWidget {
  const EmergencyContactListItem({
    super.key, required this.emergencyContact
  });

  final EmergencyContact emergencyContact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(emergencyContact.name),
      subtitle: Text('Email: ${emergencyContact.email}'),
    );
  }
}