import 'package:flutter_tts/flutter_tts.dart';

class SpeakText {
  FlutterTts flutterTts = FlutterTts();
  String textToSpeak = "";
  SpeakText({required this.textToSpeak});

  void initializeTTS() {
    flutterTts.setStartHandler(() {});

    flutterTts.setCompletionHandler(() {
      print("TTS Complete");
    });

    flutterTts.setErrorHandler((msg) {
      print("TTS Error: $msg");
    });
  }

  Future speak() async {
    if (textToSpeak.isNotEmpty) {
      await flutterTts.speak(textToSpeak);
    }
  }
}
