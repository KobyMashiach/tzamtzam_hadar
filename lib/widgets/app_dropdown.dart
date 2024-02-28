import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';

class AppDropDown extends StatefulWidget {
  final void Function(String?) onChanged;
  final List<String> listValues;
  final String? hintText;

  const AppDropDown(
      {super.key,
      required this.onChanged,
      required this.listValues,
      this.hintText});

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.listValues.first == "" ? null : widget.listValues.first,
      items: widget.listValues.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Center(
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: AppTextStyle().dropDownValues,
            ),
          ),
        );
      }).toList(),
      onChanged: widget.onChanged,
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
