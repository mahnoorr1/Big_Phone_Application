import 'package:flutter/material.dart';

class DialerWidget extends StatefulWidget {
  final Orientation orientation;
  final String enteredNumber;
  final ValueChanged<String> onNumberButtonPressed;

  DialerWidget({
    required this.orientation,
    required this.enteredNumber,
    required this.onNumberButtonPressed,
  });
  @override
  State<DialerWidget> createState() => _DialerWidgetState();
}

class _DialerWidgetState extends State<DialerWidget> {
  final List<String> numbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '*',
    '0',
    '#'
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.orientation == Orientation.landscape
          ? Alignment.topRight
          : Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width < 600 &&
                widget.orientation == Orientation.portrait
            ? widget.orientation == Orientation.portrait
                ? MediaQuery.of(context).size.width * 0.6
                : MediaQuery.of(context).size.width * 0.3
            : MediaQuery.of(context).size.width * 0.4,
        height: widget.orientation == Orientation.landscape
            ? MediaQuery.of(context).size.height * 0.78
            : MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(2),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          children: numbers.map((String number) {
            return _buildDialButton(number);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDialButton(String text) {
    if (text == '*') {
      return _buildDialButtonWithPosition(text, Alignment.bottomLeft);
    } else if (text == '#') {
      return _buildDialButtonWithPosition(text, Alignment.bottomRight);
    } else {
      return _buildDialButtonWithPosition(text, Alignment.center);
    }
  }

  Widget _buildDialButtonWithPosition(String text, Alignment alignment) {
    return GestureDetector(
      onTap: () {
        widget.onNumberButtonPressed(text);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Align(
          alignment: alignment,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: widget.orientation == Orientation.landscape
                    ? MediaQuery.of(context).size.height * 0.1
                    : MediaQuery.of(context).size.height * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
