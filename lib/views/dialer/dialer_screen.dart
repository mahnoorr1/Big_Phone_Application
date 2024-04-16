import 'package:flutter/material.dart';

import 'mobile_screen.dart';
import 'tablet_screen.dart';

class DialerScreen extends StatefulWidget {
  const DialerScreen({Key? key}) : super(key: key);

  @override
  State<DialerScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<DialerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        title: const Text('Kontakte'),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 600 &&
                orientation == Orientation.portrait) {
              return MobileScreen();
            } else if (constraints.maxHeight < 600 &&
                orientation == Orientation.landscape) {
              return MobileScreen();
            } else {
              return const TabletScreen();
            }
          },
        );
      }),
    );
  }
}
