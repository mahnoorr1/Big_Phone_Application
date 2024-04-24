import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../contacts/contact_screen.dart';
import '../settings/settings_screen.dart';
import 'dialer_widget.dart';

class TabletScreen extends StatefulWidget {
  @override
  State<TabletScreen> createState() => _TabletScreenState();
}

class _TabletScreenState extends State<TabletScreen> {
  String enteredNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 30,
        title: const Text(
          'Telefon',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _buildPortraitLayout(orientation);
          } else {
            return _buildLandscapeLayout(orientation);
          }
        },
      ),
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

  Widget _buildPortraitLayout(Orientation orientation) {
    return Builder(
      builder: (context) {
        double maxWidth = MediaQuery.of(context).size.width * 0.85;
        double initialFontSize = maxWidth * 0.13;
        double fontSize = initialFontSize;

        return Consumer<LayoutPercentageProvider>(
          builder: (context, size, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Consumer<FontStyleProvider>(
                        builder: (context, fontStyleState, _) {
                          return Text(
                            enteredNumber,
                            style: TextStyle(
                              fontSize: size.layoutPercentage == 1.0
                                  ? fontSize
                                  : size.layoutPercentage == 0.75
                                      ? fontSize * 0.75
                                      : fontSize * 0.5,
                              fontStyle: fontStyleState.fontStyle == 'italic'
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                              fontWeight: fontStyleState.fontStyle == 'bold'
                                  ? FontWeight.bold
                                  : FontWeight.w300,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                DialerWidget(
                  enteredNumber: enteredNumber,
                  onNumberButtonPressed: onNumberButtonPressed,
                ),
                const SizedBox(
                  height: 20,
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
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    _buildActionButton(
                      icon: Icons.phone,
                      color: Colors.green,
                      onTap: onCallTap,
                      orientation: orientation,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
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
      },
    );
  }

  Widget _buildLandscapeLayout(Orientation orientation) {
    return Consumer<FontStyleProvider>(
      builder: (context, fontStyleState, _) {
        return Consumer<LayoutPercentageProvider>(
          builder: (context, size, _) {
            return Builder(builder: (context) {
              double maxWidth = MediaQuery.of(context).size.width * 0.5;
              double initialFontSize = maxWidth * 0.145;
              double fontSize = initialFontSize;

              TextPainter textPainter = TextPainter(
                text: TextSpan(
                  text: enteredNumber,
                  style: TextStyle(
                    fontSize: size.layoutPercentage == 1.0
                        ? fontSize
                        : size.layoutPercentage == 0.75
                            ? fontSize * 0.75
                            : fontSize * 0.5,
                    fontStyle: fontStyleState.fontStyle == 'italic'
                        ? FontStyle.italic
                        : FontStyle.normal,
                    fontWeight: fontStyleState.fontStyle == 'bold'
                        ? FontWeight.bold
                        : FontWeight.w300,
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
                    fontSize: size.layoutPercentage == 1.0
                        ? fontSize
                        : size.layoutPercentage == 0.75
                            ? fontSize * 0.75
                            : fontSize * 0.5,
                    fontStyle: fontStyleState.fontStyle == 'italic'
                        ? FontStyle.italic
                        : FontStyle.normal,
                    fontWeight: fontStyleState.fontStyle == 'bold'
                        ? FontWeight.bold
                        : FontWeight.w300,
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
                            fontSize: size.layoutPercentage == 1.0
                                ? fontSize
                                : size.layoutPercentage == 0.75
                                    ? fontSize * 0.75
                                    : fontSize * 0.5,
                            fontStyle: fontStyleState.fontStyle == 'italic'
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: fontStyleState.fontStyle == 'bold'
                                ? FontWeight.bold
                                : FontWeight.w300,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.02),
                            _buildActionButton(
                              icon: Icons.list,
                              color: Colors.blue,
                              onTap: onListTap,
                              orientation: orientation,
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.02),
                            _buildActionButton(
                              icon: Icons.phone,
                              color: Colors.green,
                              onTap: onCallTap,
                              orientation: orientation,
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.02),
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
                      enteredNumber: enteredNumber,
                      onNumberButtonPressed: onNumberButtonPressed,
                    ),
                  ],
                ),
              );
            });
          },
        );
      },
    );
  }

  Widget _buildActionButton(
      {required IconData icon,
      required Color color,
      required VoidCallback onTap,
      required Orientation orientation}) {
    return Consumer<LayoutPercentageProvider>(
      builder: (context, size, _) {
        double iconSizePortrait = size.layoutPercentage == 1.0
            ? MediaQuery.of(context).size.width * 0.2
            : size.layoutPercentage == 0.75
                ? MediaQuery.of(context).size.width * 0.17
                : MediaQuery.of(context).size.width * 0.14;

        double iconSizeLandscape = size.layoutPercentage == 1.0
            ? MediaQuery.of(context).size.width * 0.25
            : size.layoutPercentage == 0.75
                ? MediaQuery.of(context).size.width * 0.21
                : MediaQuery.of(context).size.width * 0.18;
        return Consumer<BorderLineProvider>(
          builder: (context, borderLineState, _) {
            return Container(
              width: orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.width * 0.24
                  : MediaQuery.of(context).size.height * 0.26,
              height: orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.width * 0.24
                  : MediaQuery.of(context).size.height * 0.26,
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
              child: GestureDetector(
                onTap: onTap,
                child: Icon(
                  icon,
                  color: color,
                  size: orientation == Orientation.portrait
                      ? iconSizePortrait
                      : iconSizeLandscape,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
