import 'package:flutter/material.dart';

class TextHolder extends StatelessWidget {
  final String text;
  const TextHolder({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .stretch, // Add this line to stretch the container to match the parent's width
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
              textAlign: TextAlign.center, // Center the text horizontally
            ),
          ),
          // You can add more widgets here that will appear below the first text widget
        ],
      ),
    );
  }
}
