import 'package:flutter/material.dart';

import 'mobile_screen.dart';
import 'tablet_screen.dart';

class DialerScreen extends StatefulWidget {
  const DialerScreen({Key? key}) : super(key: key);

  @override
  State<DialerScreen> createState() => _DialerScreenState();
}

class _DialerScreenState extends State<DialerScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      if (MediaQuery.of(context).size.width < 600 ||
          MediaQuery.of(context).size.height < 600) {
        return MobileScreen();
      } else {
        return const TabletScreen();
      }
    });
  }
}
