import 'package:big_phone_us_new/stripe/stripe_payment.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Abonnementpläne',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
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
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      price,
                      style: TextStyle(
                        fontSize: 32,
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
                      child: const Icon(
                        Icons.check,
                        color: Color.fromARGB(255, 21, 156, 26),
                        size: 28,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      details,
                      style: const TextStyle(fontSize: 20),
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
                        child: const Text(
                          "Abonnieren",
                          style: TextStyle(fontSize: 28),
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
