import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../settings/settings_screen.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  Iterable<Contact>? _contacts;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    if (permissionStatus.isGranted) {
      final contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts;
      });
    } else {
      print('Permission to access contacts denied.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontakte'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: const Icon(Icons.settings),
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
      body: _contacts != null
          ? _buildContactsGrid()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildContactsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        childAspectRatio: 3,
      ),
      itemCount: _contacts!.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pop(); // Navigate back
            },
            child: Consumer<LayoutPercentageProvider>(
              builder: (context, state, _) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.list,
                      color: Colors.blue, size: 55.0 * state.layoutPercentage),
                );
              },
            ),
          );
        } else {
          Contact contact = _contacts!.elementAt(index - 1);
          return _buildContactItem(contact);
        }
      },
    );
  }

  Widget _buildContactItem(Contact contact) {
    String phoneNumber = contact.phones != null && contact.phones!.isNotEmpty
        ? contact.phones!.first.value ?? ''
        : '';

    return Consumer<LayoutPercentageProvider>(
      builder: (context, state, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double itemWidth = constraints.maxWidth;
            double itemHeight = itemWidth * 0.4;

            return InkWell(
              onTap: () async {
                _showConfirmationDialog(contact.displayName ?? '', phoneNumber);
              },
              child: Container(
                width: itemWidth,
                height: itemHeight,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      contact.displayName ?? '',
                      style: TextStyle(
                        fontSize: itemWidth * 0.25 * state.layoutPercentage,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showConfirmationDialog(
      String contactName, String phoneNumber) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '$contactName\nanrufen?',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: const Text(
                      'Nein',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _makeCall(phoneNumber);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.green),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: const Text(
                      'Ja',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _makeCall(String phoneNumber) async {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }
}
