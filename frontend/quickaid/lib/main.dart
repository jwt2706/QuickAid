import 'package:flutter/material.dart';
import 'package:quickaid/widget/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App with Theme',
      // Here begins the spell of theming
      theme: ThemeData(
        // The brightness, dark as a moonless night or light as the sun at its zenith
        brightness: Brightness.light,
        // Primary swatch, the royal color that adorns your app's domain
        primarySwatch: Colors.blue,
        // Font family, the scribe that pens the text in your realm
        fontFamily: 'Montserrat',
        // Text theme, the decree that dictates the style of thy texts
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: Home(),
    );
  }
}
