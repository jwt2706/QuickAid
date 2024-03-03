import 'package:flutter/material.dart';
import 'package:quickaid/resources/emergency_contact.dart';

class EditEmergencyContactDialog extends StatefulWidget {
  final EmergencyContact emergencyContact;
  final Function(EmergencyContact) onSave;
  final Function(EmergencyContact) onDelete;

  const EditEmergencyContactDialog({
    super.key,
    required this.emergencyContact,
    required this.onSave,
    required this.onDelete,
  });

  @override
  State<EditEmergencyContactDialog> createState() => _EditEmergencyContactDialogState();
}

class _EditEmergencyContactDialogState extends State<EditEmergencyContactDialog> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.emergencyContact.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Contact Info'),
      content: Column(children: [
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
              controller: _nameController,
              onChanged: (value) {
                setState(() {
                  widget.emergencyContact.name = value;
                });
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
                  setState(() {
                    widget.emergencyContact.phoneNumber = value;
                  });
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
                  setState(() {
                    widget.emergencyContact.email = value;
                  });
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
                widget.onDelete(widget.emergencyContact); // Delete contact
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                widget.onSave(widget.emergencyContact); // Save changes
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