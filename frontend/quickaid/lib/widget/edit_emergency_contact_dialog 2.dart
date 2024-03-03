import 'package:flutter/material.dart';
import 'package:quickaid/resources/emergency_contact.dart';

class EditEmergencyContactDialog extends StatefulWidget {
  final EmergencyContact emergencyContact;
  final Function(EmergencyContact) onSave;

  const EditEmergencyContactDialog({
    super.key,
    required this.emergencyContact,
    required this.onSave,
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
      content: Row(
        children: [
          const Text(
            'Full Name:',
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
