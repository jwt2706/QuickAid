import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quickaid/pages/login_page.dart';
import 'package:quickaid/pages/response.dart';
import 'package:quickaid/resources/contacts.dart';
import 'package:quickaid/resources/local_storage.dart';
import 'package:quickaid/widget/text_container.dart';
import 'package:quickaid/widget/voice.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class IconButtonToggle extends StatefulWidget {
  @override
  _IconButtonToggleState createState() => _IconButtonToggleState();
}

class _IconButtonToggleState extends State<IconButtonToggle> {
  bool _isMicOn = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_isMicOn ? Icons.mic : Icons.stop),
      onPressed: () {
        setState(() {
          _isMicOn = !_isMicOn;
        });
      },
    );
  }
}

class _HomeState extends State<Home> {
  final GlobalKey<MicFloatingButtonState> micKey =
      GlobalKey<MicFloatingButtonState>();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _isMicOn = false;
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
              print('Recognized Words: $_text'); // Log the recognized words
              if (result.finalResult) {
                _stopListening();
              }
            });
          },
        );
      } else {
        print(
            'Speech recognition unavailable'); // Log if speech recognition is unavailable
      }
    } else {
      _stopListening();
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
    micKey.currentState?.stopAnimation();
    print('Stopped listening'); // Log when the app stops listening
  }

  void moveNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApiHandler(text: _text),
      ),
    );
  }

  void handleMic() {
    setState(() {
      _isMicOn = !_isMicOn;
      if (_isMicOn) {
        _listen();
      } else {
        _stopListening();
      }
    });
  }

  void _navigateToContactsPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min, // Use min to center the row contents
          children: <Widget>[
            Icon(Icons.local_hospital,
                size: 40, color: Colors.white), // Your icon
            SizedBox(width: 8), // Space between icon and text
            Text(
              'QuickAid',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            color: Colors.white,
            onPressed: () {
              _navigateToContactsPage(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage('assets/bg.webp'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7), // Adjust the opacity as needed
            BlendMode
                .dstATop, // This blend mode applies the color filter on top of the image
          ),
        )),
        child: Center(
          // Added a Center widget to center the text
          child: TextHolder(text: _text), // Display the _text
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: handleMic,
        child: Icon(_isMicOn ? Icons.stop : Icons.mic),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Ink(
              decoration: const ShapeDecoration(
                color: Colors.redAccent,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  // Logic to stop the microphone
                  moveNextPage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
