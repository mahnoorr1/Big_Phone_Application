import 'package:big_phone_us_new/providers/app_provider.dart';
import 'package:big_phone_us_new/views/contacts/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../settings/settings_screen.dart';
import 'dialer_widget.dart';

class MobileScreen extends StatefulWidget {
  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  String enteredNumber = '';
  double? size;
  getFontSizeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      size = prefs.getDouble('layoutPercentage');
    });
  }

  @override
  void initState() {
    super.initState();
    getFontSizeData();
  }

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
    return Builder(builder: (context) {
      double maxWidth = MediaQuery.of(context).size.width - 20;
      double initialFontSize = maxWidth * 0.18;

      return Consumer<FontStyleProvider>(
        builder: (context, fontStyleState, _) {
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              toolbarHeight: 30,
              title: Consumer<FontProvider>(
                builder: (context, fontState, _) {
                  return Text(
                    'Telefon',
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: fontStyleState.fontStyle == 'italic'
                          ? FontStyle.italic
                          : FontStyle.normal,
                      fontWeight: fontStyleState.fontStyle == 'bold'
                          ? FontWeight.bold
                          : FontWeight.w300,
                      fontFamily: fontState.font,
                    ),
                  );
                },
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
            body: OrientationBuilder(builder: (context, orientation) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Consumer<LayoutPercentageProvider>(
                    builder: (context, size, _) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              enteredNumber,
                              style: TextStyle(
                                fontSize: size.layoutPercentage == 1.0
                                    ? initialFontSize
                                    : size.layoutPercentage == 0.75
                                        ? initialFontSize * 0.75
                                        : initialFontSize * 0.5,
                                fontStyle: fontStyleState.fontStyle == 'italic'
                                    ? FontStyle.italic
                                    : FontStyle.normal,
                                fontWeight: fontStyleState.fontStyle == 'bold'
                                    ? FontWeight.bold
                                    : FontWeight.w300,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DialerWidget(
                    enteredNumber: enteredNumber,
                    onNumberButtonPressed: onNumberButtonPressed,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      _buildActionButton(
                        icon: Icons.list,
                        color: Colors.blue,
                        onTap: onListTap,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      _buildActionButton(
                        icon: Icons.phone,
                        color: Colors.green,
                        onTap: onCallTap,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      _buildActionButton(
                        icon: Icons.arrow_back,
                        color: Colors.blue,
                        onTap: onBackspaceTap,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    ],
                  ),
                ],
              );
            }),
          );
        },
      );
    });
  }

  Widget _buildLandscapeLayout() {
    return Consumer<FontProvider>(
      builder: (context, fontState, _) {
        return Consumer<FontStyleProvider>(
          builder: (context, fontStyleState, _) {
            return Consumer<LayoutPercentageProvider>(
              builder: (context, size, _) {
                return Builder(builder: (context) {
                  double maxWidth = MediaQuery.of(context).size.width * 0.6;
                  double initialFontSize = maxWidth * 0.145;
                  double fontSize = initialFontSize;

                  TextPainter textPainter = TextPainter(
                    text: TextSpan(
                      text: enteredNumber,
                      style: TextStyle(
                        fontSize: size.layoutPercentage == 1.0
                            ? initialFontSize
                            : size.layoutPercentage == 0.75
                                ? initialFontSize * 0.75
                                : initialFontSize * 0.5,
                        color: Theme.of(context).colorScheme.primary,
                        fontStyle: fontStyleState.fontStyle == 'italic'
                            ? FontStyle.italic
                            : FontStyle.normal,
                        fontWeight: fontStyleState.fontStyle == 'bold'
                            ? FontWeight.bold
                            : FontWeight.w300,
                        fontFamily: fontState.font,
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
                        color: Theme.of(context).colorScheme.primary,
                        fontStyle: fontStyleState.fontStyle == 'italic'
                            ? FontStyle.italic
                            : FontStyle.normal,
                        fontWeight: fontStyleState.fontStyle == 'bold'
                            ? FontWeight.bold
                            : FontWeight.w300,
                        fontFamily: fontState.font,
                      ),
                    );
                    textPainter.layout();
                  }
                  return Scaffold(
                    extendBody: true,
                    appBar: AppBar(
                      toolbarHeight: 30,
                      title: Text(
                        'Telefon',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: fontStyleState.fontStyle == 'italic'
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontWeight: fontStyleState.fontStyle == 'bold'
                              ? FontWeight.bold
                              : FontWeight.w300,
                          fontFamily: fontState.font,
                        ),
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
                                    fontSize: size.layoutPercentage == 1.0
                                        ? fontSize
                                        : size.layoutPercentage == 0.75
                                            ? fontSize * 0.75
                                            : fontSize * 0.5,
                                    fontStyle:
                                        fontStyleState.fontStyle == 'italic'
                                            ? FontStyle.italic
                                            : FontStyle.normal,
                                    fontWeight:
                                        fontStyleState.fontStyle == 'bold'
                                            ? FontWeight.bold
                                            : FontWeight.w300,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontFamily: fontState.font,
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
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    _buildActionButton(
                                      icon: Icons.list,
                                      color: Colors.blue,
                                      onTap: onListTap,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    _buildActionButton(
                                      icon: Icons.phone,
                                      color: Colors.green,
                                      onTap: onCallTap,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    _buildActionButton(
                                      icon: Icons.arrow_back,
                                      color: Colors.blue,
                                      onTap: onBackspaceTap,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.02),
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
              },
            );
          },
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Consumer<LayoutPercentageProvider>(
      builder: (context, size, _) {
        double iconSizePortrait = size.layoutPercentage == 1.0
            ? MediaQuery.of(context).size.width * 0.2
            : size.layoutPercentage == 0.75
                ? MediaQuery.of(context).size.width * 0.17
                : MediaQuery.of(context).size.width * 0.14;

        double iconSizeLandscape = size.layoutPercentage == 1.0
            ? MediaQuery.of(context).size.height * 0.25
            : size.layoutPercentage == 0.75
                ? MediaQuery.of(context).size.height * 0.21
                : MediaQuery.of(context).size.height * 0.18;
        return Consumer<BorderLineProvider>(
          builder: (context, borderLineState, _) {
            return Container(
              width: MediaQuery.of(context).size.width < 600
                  ? MediaQuery.of(context).size.width * 0.29
                  : MediaQuery.of(context).size.height * 0.34,
              height: MediaQuery.of(context).size.width < 600
                  ? MediaQuery.of(context).size.width * 0.29
                  : MediaQuery.of(context).size.height * 0.34,
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
                  size: MediaQuery.of(context).size.width < 600
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
