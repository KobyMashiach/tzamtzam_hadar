// ignore_for_file: prefer_typing_uninitialized_variables, file_names, must_be_immutable

import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final controller;
  final bool? enable;
  final String hintText;
  final TextInputType? keyboard;
  final bool? checkIfPassword;
  final bool? readOnly;
  final int? maxLines;
  final int? maxLength;
  void Function(String)? onChanged;
  final EdgeInsets? padding;
  final TextInputAction? textInputAction;
  final String? counterText;
  final bool? hintTextCenter;
  AppTextField(
      {super.key,
      this.controller,
      this.enable,
      this.keyboard,
      this.textInputAction,
      this.checkIfPassword = false,
      this.hintTextCenter,
      required this.hintText,
      this.readOnly,
      this.maxLines,
      this.maxLength,
      this.onChanged,
      this.padding,
      this.counterText});

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _passwordVisible;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    bool checkPassword = widget.checkIfPassword ?? false;
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
          textAlign: widget.hintTextCenter == true
              ? TextAlign.center
              : TextAlign.start,
          onChanged: widget.onChanged,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines ?? 1,
          textInputAction: widget.textInputAction,
          style: const TextStyle(color: Colors.black),
          enabled: widget.enable ?? true,
          controller: widget.controller,
          obscureText: checkPassword ? !_passwordVisible : false,
          keyboardType: widget.keyboard ?? TextInputType.text,
          readOnly: widget.readOnly ?? false,
          decoration: InputDecoration(
            counterText: widget.counterText,
            suffixIcon: widget.checkIfPassword!
                ? IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(32.0), // Set the radius here
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(32.0), // Set the radius here
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
          )),
    );
  }
}
