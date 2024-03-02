import 'package:flutter/material.dart';

class MicFloatingButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const MicFloatingButton(
      {super.key, required this.onPressed, this.icon = Icons.mic});

  @override
  State<MicFloatingButton> createState() => MicFloatingButtonState();
}

class MicFloatingButtonState extends State<MicFloatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void startAnimation() {
    _controller.repeat(reverse: true);
  }

  void stopAnimation() {
    _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: FloatingActionButton(
        onPressed: widget.onPressed,
        tooltip: 'Voice',
        child: Icon(widget.icon),
      ),
    );
  }
}
