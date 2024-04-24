import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

class DropdownButtonExample extends StatefulWidget {
  final List<String> list;
  final String initial;
  final void Function(String) onSelected;

  const DropdownButtonExample({
    required this.list,
    required this.onSelected,
    required this.initial,
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String? dropdownValue; // Initialize with null to avoid assertion error

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
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
                style: TextStyle(fontSize: 20 * state.layoutPercentage),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
