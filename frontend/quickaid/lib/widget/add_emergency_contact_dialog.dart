import 'package:flutter/material.dart';
import 'package:quickaid/resources/emergency_contact.dart';

class AddEmergencyContactDialog extends StatefulWidget {
  final Function(EmergencyContact) onSave;

  const AddEmergencyContactDialog({
    super.key,
    required this.onSave,
  });

  @override
  State<AddEmergencyContactDialog> createState() => _AddEmergencyContactDialogState();
}

class _AddEmergencyContactDialogState extends State<AddEmergencyContactDialog> {
  var newContact = EmergencyContact("EEEE", "EEEE", "EEEE", Relationship.friend);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Contact Info'),
      content: 
      Column(children: [
         Row(
        children: [
          const Text(
            'Name:',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Please enter a full name',
              ),
              onChanged: (value) {
                newContact.name = value;
              },
            ),
          ),
        ],
      ),
      Row(
        children: [
          const Text(
            'Phone:',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Please enter a phone number',
              ),
              onChanged: (value) {
                  newContact.phoneNumber = value;
              },
            ),
          ),
        ],
      ),
      Row(
        children: [
          const Text(
            'Email:',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Please enter an email address',
              ),
              onChanged: (value) {
                  newContact.email = value;
              },
            ),
          ),
        ],
      ),
      Row(
        children: [
          const Text(
            'Relationship:',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _showRelationshipPicker(context);
              },
              child: const Text("Pick relationship"),
            ),
          ),
        ],
      ),
      ]),
      actions: <Widget>[
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                widget.onSave(newContact);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ],
    );
  }
}

 Future<void> _showRelationshipPicker(BuildContext context) async {
    Relationship? selectedEnum = await showModalBottomSheet<Relationship>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: Relationship.values.length,
          itemBuilder: (context, index) {
            final enumValue = Relationship.values[index];
            return ListTile(
              title: Text(enumValue.toString().split('.').last),
              onTap: () {
                Navigator.pop(context, enumValue);
              },
            );
          },
        );
      },
    );

    if (selectedEnum != null) {
      print('Selected enum: $selectedEnum');
    }
  }
