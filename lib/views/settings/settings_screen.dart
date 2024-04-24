import 'package:big_phone_us_new/components/switch.dart';
import 'package:big_phone_us_new/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/drop_down.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> fontSizes = ['100%', '75%', '50%'];
  double? selectedFontSize;
  double? font32;
  double? font28;
  double? font20;
  double? size;
  getFontSizeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      size = prefs.getDouble('layoutPercentage');
      font28 = 28 * size!;
      font32 = 32 * size!;
      font20 = 22 * size!;
    });
  }

  @override
  void initState() {
    super.initState();
    getFontSizeData();
  }

  @override
  Widget build(BuildContext context) {
    return size == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Einstellungen'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const ThemeSwitcher(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Font Size: ',
                          style: TextStyle(fontSize: font28),
                        ),
                        Consumer<LayoutPercentageProvider>(
                          builder: (context, state, _) {
                            return DropdownButtonExample(
                              list: fontSizes,
                              initial: size == 1.0
                                  ? '100%'
                                  : size == 0.75
                                      ? '75%'
                                      : '50%',
                              onSelected: (value) async {
                                setState(() {
                                  selectedFontSize = value == '100%'
                                      ? 1.0
                                      : value == '75%'
                                          ? 0.75
                                          : 0.6;
                                  font20 = 22 * selectedFontSize!;
                                  font28 = 28 * selectedFontSize!;
                                  font32 = 32 * selectedFontSize!;
                                  state.setLayoutPercentage(selectedFontSize!);
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Abonnementpläne',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: (font32),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: [
                          subscriptionCard(
                            'Standard',
                            'Frei',
                            'Anzeigen aktiviert\nStandardmäßig abonniert',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          subscriptionCard(
                            'Monatlicher Plan',
                            '€10',
                            'Keine Werbung\nBessere Erfahrung',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          subscriptionCard(
                            'Jahresplan',
                            '€50',
                            'Keine Werbung\nBessere Erfahrung',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget subscriptionCard(
    String title,
    String price,
    String details,
  ) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 20, left: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(70),
          topRight: Radius.circular(70),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: font28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      price,
                      style: TextStyle(
                        fontSize: font32,
                        fontWeight: FontWeight.w600,
                        color: price == 'Frei'
                            ? const Color.fromARGB(255, 21, 156, 26)
                            : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: const Color.fromARGB(255, 21, 156, 26),
                          )),
                      child: Icon(
                        Icons.check,
                        color: Color.fromARGB(255, 21, 156, 26),
                        size: font28,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      details,
                      style: TextStyle(fontSize: font20),
                    ),
                  ],
                ),
              ),
              price != 'Frei'
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.red),
                          foregroundColor:
                              WidgetStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text(
                          "Abonnieren",
                          style: TextStyle(fontSize: font28),
                        ),
                        onPressed: () {
                          // Payment().makePayment(context, price);
                        },
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void bottomSheet(BuildContext context) {}
}
