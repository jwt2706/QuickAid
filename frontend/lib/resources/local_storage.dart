import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static const String _textKey = 'userInput';

  // Method to save text to local storage
  Future<bool> save(String text) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_textKey, text);
  }

  // Method to retrieve text from local storage
  Future<String?> getText() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_textKey);
  }

  // Method to remove text from local storage
  Future<bool> remove() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_textKey);
  }
}
