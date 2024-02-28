import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';

class PageViewButton extends StatelessWidget {
  final bool isSelected;
  final String text;
  final void Function()? onPressed;
  final bool? shouldNotUseExpanded;

  const PageViewButton(
      {super.key,
      this.isSelected = false,
      required this.text,
      this.onPressed,
      this.shouldNotUseExpanded});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    if (shouldNotUseExpanded != null && shouldNotUseExpanded == true) {
      return buildGestureDetector(themeData, context, isSelected);
    }
    return Expanded(
      child: buildGestureDetector(themeData, context, isSelected),
    );
  }

  GestureDetector buildGestureDetector(
      ThemeData themeData, BuildContext context, bool isSelected) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Column(
        children: [
          innerText(isSelected),
          kheasydevDivider(
            black: true,
            height: isSelected ? 3 : 1,
          ),
        ],
      ),
    );
  }

  Widget innerText(bool isSelected) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }
}
