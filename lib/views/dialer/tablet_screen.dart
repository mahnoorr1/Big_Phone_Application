import 'package:flutter/material.dart';

import 'dialer_widget.dart';

class TabletScreen extends StatefulWidget {
  const TabletScreen({super.key});

  @override
  State<TabletScreen> createState() => _TabletScreenState();
}

class _TabletScreenState extends State<TabletScreen> {
  String enteredNumber = '';
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return _buildPortraitLayout(orientation, context);
        } else {
          return _buildLandscapeLayout(orientation);
        }
      },
    );
  }

  void onListTap() {}

  void onCallTap() {}

  void onBackspaceTap() {
    if (enteredNumber.isNotEmpty) {
      setState(() {
        enteredNumber = enteredNumber.substring(0, enteredNumber.length - 1);
      });
    }
  }

  void onNumberButtonPressed(String number) {
    setState(() {
      enteredNumber += number;
    });
  }

  Widget _buildPortraitLayout(Orientation orientation, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth * 0.85;
        double initialFontSize = maxWidth * 0.13;
        double fontSize = initialFontSize;

        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: enteredNumber,
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        while (textPainter.size.width > maxWidth) {
          fontSize -= 1.0;
          textPainter.text = TextSpan(
            text: enteredNumber,
            style: TextStyle(
              fontSize: fontSize,
            ),
          );
          textPainter.layout();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              enteredNumber,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            DialerWidget(
              orientation: orientation,
              enteredNumber: enteredNumber,
              onNumberButtonPressed: onNumberButtonPressed,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  icon: Icons.list,
                  color: Colors.blue,
                  onTap: onListTap,
                  orientation: orientation,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                _buildActionButton(
                  icon: Icons.phone,
                  color: Colors.green,
                  onTap: onCallTap,
                  orientation: orientation,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                _buildActionButton(
                  icon: Icons.arrow_back,
                  color: Colors.blue,
                  onTap: onBackspaceTap,
                  orientation: orientation,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildLandscapeLayout(Orientation orientation) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth * 0.5;
      double initialFontSize = maxWidth * 0.145;
      double fontSize = initialFontSize;

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: enteredNumber,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      while (textPainter.size.width > maxWidth) {
        fontSize -= 1.0;
        textPainter.text = TextSpan(
          text: enteredNumber,
          style: TextStyle(
            fontSize: fontSize,
          ),
        );
        textPainter.layout();
      }
      return Padding(
        padding: const EdgeInsets.only(right: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  enteredNumber,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    _buildActionButton(
                      icon: Icons.list,
                      color: Colors.blue,
                      onTap: onListTap,
                      orientation: orientation,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height * 0.05),
                    _buildActionButton(
                      icon: Icons.phone,
                      color: Colors.green,
                      onTap: onCallTap,
                      orientation: orientation,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height * 0.05),
                    _buildActionButton(
                      icon: Icons.arrow_back,
                      color: Colors.blue,
                      onTap: onBackspaceTap,
                      orientation: orientation,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            DialerWidget(
              orientation: orientation,
              enteredNumber: enteredNumber,
              onNumberButtonPressed: onNumberButtonPressed,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildActionButton(
      {required IconData icon,
      required Color color,
      required VoidCallback onTap,
      required Orientation orientation}) {
    return Container(
      width: orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width * 0.16
          : MediaQuery.of(context).size.height * 0.16,
      height: orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width * 0.16
          : MediaQuery.of(context).size.height * 0.16,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          color: color,
          size: orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width * 0.1
              : MediaQuery.of(context).size.height * 0.1,
        ),
      ),
    );
  }
}
