import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quickaid/pages/respnose.dart';
import 'package:quickaid/resources/local_storage.dart';
import 'package:quickaid/widget/text_container.dart';
import 'package:quickaid/widget/voice.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<MicFloatingButtonState> micKey =
      GlobalKey<MicFloatingButtonState>();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
              if (result.finalResult) {
                _stopListening();
              }
            });
          },
        );
      }
    } else {
      _stopListening();
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApiHandler(text: _text),
      ),
    );
  }

  void handleMic() {
    setState(() {
      // micOn = !micOn;
      if (_isListening) {
        micKey.currentState?.startAnimation();
      } else {
        micKey.currentState?.stopAnimation();
      }
    });
    _listen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text(
          'Quickaid',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        leading: const Icon(
          Icons.local_hospital,
          size: 40, // Increases the icon size
          color: Colors.white, // Changes the icon color to red
        ),
      ),
      body: TextHolder(text: _text),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: MicFloatingButton(
        key: micKey,
        onPressed: handleMic,
      ),
    );
  }
}
