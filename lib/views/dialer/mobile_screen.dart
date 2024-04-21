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
          return _buildPortraitLayout();
        } else {
          return _buildLandscapeLayout();
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

  Widget _buildPortraitLayout() {
    double maxWidth = MediaQuery.of(context).size.width - 20;
    double initialFontSize = maxWidth * 0.18;

    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  enteredNumber,
                  style: TextStyle(
                    fontSize: initialFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DialerWidget(
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
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                _buildActionButton(
                  icon: Icons.phone,
                  color: Colors.green,
                  onTap: onCallTap,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                _buildActionButton(
                  icon: Icons.arrow_back,
                  color: Colors.blue,
                  onTap: onBackspaceTap,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildLandscapeLayout() {
    return Builder(builder: (context) {
      double maxWidth = MediaQuery.of(context).size.width * 0.6;
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
      return Scaffold(
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: 30,
          title: const Text(
            'Telefon',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey,
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          return Padding(
            padding: const EdgeInsets.only(right: 0),
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
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        _buildActionButton(
                          icon: Icons.list,
                          color: Colors.blue,
                          onTap: onListTap,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.height * 0.05),
                        _buildActionButton(
                          icon: Icons.phone,
                          color: Colors.green,
                          onTap: onCallTap,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.height * 0.05),
                        _buildActionButton(
                          icon: Icons.arrow_back,
                          color: Colors.blue,
                          onTap: onBackspaceTap,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.height * 0.05),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                DialerWidget(
                  enteredNumber: enteredNumber,
                  onNumberButtonPressed: onNumberButtonPressed,
                ),
              ],
            ),
          );
        }),
      );
    });
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width < 600
          ? MediaQuery.of(context).size.width * 0.24
          : MediaQuery.of(context).size.height * 0.24,
      height: MediaQuery.of(context).size.width < 600
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
          size: MediaQuery.of(context).size.width < 600
              ? MediaQuery.of(context).size.width * 0.2
              : MediaQuery.of(context).size.height * 0.2,
        ),
      ),
    );
  }
}
