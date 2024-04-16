import 'package:big_phone_us_new/views/contacts/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'dialer_widget.dart';

class MobileScreen extends StatefulWidget {
  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
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

  void onListTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactsScreen(),
      ),
    );
  }

  void onCallTap() async {
    if (enteredNumber.isNotEmpty) {
      await FlutterPhoneDirectCaller.callNumber(enteredNumber);
    }
  }

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
        double maxWidth = constraints.maxWidth - 20;
        double initialFontSize = maxWidth * 0.18;
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
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DialerWidget(
              orientation: orientation,
              enteredNumber: enteredNumber,
              onNumberButtonPressed: onNumberButtonPressed,
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
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                _buildActionButton(
                  icon: Icons.phone,
                  color: Colors.green,
                  onTap: onCallTap,
                  orientation: orientation,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                _buildActionButton(
                  icon: Icons.arrow_back,
                  color: Colors.blue,
                  onTap: onBackspaceTap,
                  orientation: orientation,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildLandscapeLayout(Orientation orientation) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth * 0.6;
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
                    SizedBox(width: MediaQuery.of(context).size.height * 0.05),
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
          ? MediaQuery.of(context).size.width * 0.24
          : MediaQuery.of(context).size.height * 0.24,
      height: orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width * 0.24
          : MediaQuery.of(context).size.height * 0.24,
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
              ? MediaQuery.of(context).size.width * 0.2
              : MediaQuery.of(context).size.height * 0.2,
        ),
      ),
    );
  }
}
