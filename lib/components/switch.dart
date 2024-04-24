import 'package:big_phone_us_new/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../theme.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<LayoutPercentageProvider>(
      builder: (context, state, _) {
        return Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                themeProvider.themeDataStyle == ThemeDataStyle.dark
                    ? 'Dark Theme'
                    : 'Light Theme',
                style: TextStyle(fontSize: 25.0 * state.layoutPercentage),
              ),
              const SizedBox(width: 10.0),
              Transform.scale(
                scale: 1,
                child: Switch(
                  value: themeProvider.themeDataStyle == ThemeDataStyle.dark
                      ? true
                      : false,
                  onChanged: (isOn) {
                    themeProvider.changeTheme();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
