import 'package:flutter/material.dart';
import 'package:quickaid/resources/emergency_contact.dart';
import 'package:quickaid/widget/emergency_contact_list_item.dart';

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
        var emergencyContact = emergencyContacts[index];

        return GestureDetector (
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EditEmergencyContactDialog(emergencyContact: emergencyContact);
              },
            );
          },
          child: EmergencyContactListItem(
            emergencyContact: emergencyContact
          )
        );
      },
    );
  }
}

class EditEmergencyContactDialog extends StatelessWidget {
  const EditEmergencyContactDialog({
    super.key,
    required this.emergencyContact,
  });

  final EmergencyContact emergencyContact;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Emergency Contact Details'),
      content: Text('Name: ${emergencyContact.name}\nPhone: ${emergencyContact.phoneNumber}'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}