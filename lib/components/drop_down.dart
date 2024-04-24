import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

class DropdownButtonExample extends StatefulWidget {
  final List<String> list;
  final String initial;
  final String label;
  final void Function(String) onSelected;

  const DropdownButtonExample({
    required this.list,
    required this.onSelected,
    required this.initial,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FontStyleProvider>(
      builder: (context, fontStyleState, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<LayoutPercentageProvider>(
              builder: (context, layoutState, _) {
                return Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 30 * layoutState.layoutPercentage,
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
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    dropdownValue = value;
                  });
                  widget.onSelected(value);
                }
              },
              items: widget.list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Consumer<LayoutPercentageProvider>(
                    builder: (context, state, _) {
                      return Text(
                        value,
                        style: TextStyle(
                          fontSize: 22 * state.layoutPercentage,
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
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
