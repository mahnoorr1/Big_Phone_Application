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
              Consumer<FontStyleProvider>(
                builder: (context, fontStyleState, _) {
                  return Text(
                    themeProvider.themeDataStyle == ThemeDataStyle.dark
                        ? 'Dark Theme'
                        : 'Light Theme',
                    style: TextStyle(
                      fontSize: 30.0 * state.layoutPercentage,
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
