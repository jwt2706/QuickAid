import 'package:flutter/material.dart';
import 'package:quickaid/widget/voice.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool micOn = true;
  final GlobalKey<MicFloatingButtonState> micKey =
      GlobalKey<MicFloatingButtonState>();

  void handleMic() {
    setState(() {
      micOn = !micOn;
      if (micOn) {
        micKey.currentState?.startAnimation();
      } else {
        micKey.currentState?.stopAnimation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("Hello"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: MicFloatingButton(
        key: micKey,
        onPressed: handleMic,
      ),
    );
  }
}
