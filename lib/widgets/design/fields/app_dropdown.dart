import 'package:flutter/material.dart';

class AppDropDown extends StatefulWidget {
  final void Function(String) onChanged;
  final List<String> listValues;
  final String? hintText;
  final String? value;

  const AppDropDown({
    Key? key,
    required this.onChanged,
    required this.listValues,
    this.hintText,
    this.value,
  }) : super(key: key);

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  late String? value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: widget.listValues.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Center(
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        widget.onChanged(newValue!);
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(32.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(32.0),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: widget.hintText ?? "",
        hintStyle: TextStyle(color: Colors.grey[500]),
      ),
      dropdownColor: Colors.grey[400],
      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
    );
  }
}
