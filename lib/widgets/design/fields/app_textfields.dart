// ignore_for_file: prefer_typing_uninitialized_variables, file_names, must_be_immutable

import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final controller;
  final bool? enable;
  final String hintText;
  final TextInputType? keyboard;
  final bool? checkIfPassword;
  final bool? readOnly;
  final bool? maxLinesIsNull;
  final int? maxLines;
  final int? maxLength;
  final Function(String)? onChanged;
  final VoidCallback? onClear;
  final bool? clearXIcon;
  final EdgeInsets? padding;
  final TextInputAction? textInputAction;
  final String? counterText;
  final bool? hintTextCenter;
  final bool? xIconHalf;
  AppTextField(
      {super.key,
      this.controller,
      this.enable,
      this.keyboard,
      this.xIconHalf,
      this.textInputAction,
      this.checkIfPassword = false,
      this.hintTextCenter,
      this.onClear,
      this.clearXIcon = false,
      this.maxLinesIsNull,
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
        textAlign:
            widget.hintTextCenter == true ? TextAlign.center : TextAlign.start,
        onChanged: widget.onChanged,
        maxLength: widget.maxLength,
        maxLines: widget.maxLinesIsNull == true ? null : widget.maxLines ?? 1,
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
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : widget.clearXIcon!
                  ? GestureDetector(
                      onTap: () {
                        widget.onClear?.call();
                      },
                      child: FractionallySizedBox(
                        heightFactor: widget.xIconHalf == true ? 0.1 : 0.2,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: FittedBox(
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
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
        ),
      ),
    );
  }
}
