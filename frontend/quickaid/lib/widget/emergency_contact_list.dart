import 'package:flutter/material.dart';
import 'package:quickaid/resources/emergency_contact.dart';

class EmergencyContactList extends StatefulWidget {
  final List<EmergencyContact> emergencyContacts;

  const EmergencyContactList({super.key, required this.emergencyContacts});
  @override
  State<EmergencyContactList> createState() => EmergencyContactListState();
}

class EmergencyContactListState extends State<EmergencyContactList> {
  late List<EmergencyContact> emergencyContacts;

  @override
  void initState() {
    super.initState();
    emergencyContacts = widget.emergencyContacts;
  }

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
