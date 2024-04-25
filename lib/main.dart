import 'package:big_phone_us_new/providers/app_provider.dart';
import 'package:big_phone_us_new/providers/theme_provider.dart';
import 'package:big_phone_us_new/views/dialer/dialer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<LayoutPercentageProvider>(
        create: (_) => LayoutPercentageProvider(),
      ),
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(),
      ),
      ChangeNotifierProvider<BorderLineProvider>(
        create: (_) => BorderLineProvider(),
      ),
      ChangeNotifierProvider<FontStyleProvider>(
        create: (_) => FontStyleProvider(),
      ),
      ChangeNotifierProvider<FontProvider>(
        create: (_) => FontProvider(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeDataStyle,
      home: const DialerScreen(),
    );
  }
}
