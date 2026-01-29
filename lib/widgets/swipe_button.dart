import 'package:flutter/material.dart';

class SwipeButton extends StatefulWidget {
  final VoidCallback onSwipeComplete;
  final bool isEnabled;

  const SwipeButton({
    super.key,
    required this.onSwipeComplete,
    this.isEnabled = false,
  });

  @override
  State<SwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton> {
  double _dragValue = 0.0;
  final double _maxWidth = 250.0; // Button width

  void _onDragUpdate(DragUpdateDetails details) {
    if (!widget.isEnabled) return;

    setState(() {
      _dragValue = (_dragValue + details.delta.dx).clamp(0.0, _maxWidth - 50);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (!widget.isEnabled) return;

    if (_dragValue >= _maxWidth - 55) {
      widget.onSwipeComplete();
      setState(() {
        _dragValue = _maxWidth - 50; // Keep it at end
      });
    } else {
      setState(() {
        _dragValue = 0.0; // Reset
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.isEnabled ? 1.0 : 0.5,
      child: Container(
        height: 50,
        width: _maxWidth,
        decoration: BoxDecoration(
          color: widget.isEnabled ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          children: [
            const Center(
              child: Text(
                "Swipe to Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              left: _dragValue,
              child: GestureDetector(
                onHorizontalDragUpdate: _onDragUpdate,
                onHorizontalDragEnd: _onDragEnd,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: widget.isEnabled ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
