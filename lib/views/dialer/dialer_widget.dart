import 'package:big_phone_us_new/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialerWidget extends StatefulWidget {
  final String enteredNumber;
  final ValueChanged<String> onNumberButtonPressed;

  DialerWidget({
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
    return OrientationBuilder(builder: (context, orientation) {
      return Align(
        alignment: orientation == Orientation.landscape
            ? Alignment.topRight
            : Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width < 600 &&
                  orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width * 0.87 //mobile portrait
              : orientation == Orientation.landscape
                  ? MediaQuery.of(context).size.height *
                      0.65 //mobile landscape mode
                  : orientation == Orientation.portrait &&
                          MediaQuery.of(context).size.width > 600
                      ? MediaQuery.of(context).size.width *
                          0.6 // tablet portrait
                      : orientation == Orientation.landscape
                          ? MediaQuery.of(context).size.height *
                              0.6 //tablet landscape
                          : MediaQuery.of(context).size.height * 0.4,
          height: orientation == Orientation.landscape
              ? MediaQuery.of(context).size.height * 0.9
              : MediaQuery.of(context).size.height * 0.6,
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
    });
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
      child: Consumer<LayoutPercentageProvider>(
        builder: (context, state, _) {
          return OrientationBuilder(builder: (context, orientation) {
            double mobileFont = state.layoutPercentage == 1.0
                ? MediaQuery.of(context).size.height * 0.08
                : state.layoutPercentage == 0.75
                    ? MediaQuery.of(context).size.height * 0.08 * 0.75
                    : MediaQuery.of(context).size.height * 0.08 * 0.5;
            double tabletFont = state.layoutPercentage == 1.0
                ? MediaQuery.of(context).size.width * 0.05
                : state.layoutPercentage == 0.75
                    ? MediaQuery.of(context).size.width * 0.05 * 0.75
                    : MediaQuery.of(context).size.width * 0.05 * 0.5;
            return Consumer<BorderLineProvider>(
              builder: (context, borderLineState, _) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: borderLineState.border == 0
                          ? Colors.transparent
                          : Theme.of(context).colorScheme.primary,
                      width: borderLineState.border.toDouble(),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Consumer<FontStyleProvider>(
                    builder: (context, fontStyleState, _) {
                      return Align(
                        alignment: alignment,
                        child: Center(
                          child: Text(
                            text,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width < 600
                                  ? mobileFont
                                  : tabletFont,
                              fontStyle: fontStyleState.fontStyle == 'italic'
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                              fontWeight: fontStyleState.fontStyle == 'bold'
                                  ? FontWeight.bold
                                  : FontWeight.w300,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          });
        },
      ),
    );
  }
}
