import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final bool isSelected;
  final String text;
  final void Function()? onPressed;
  final String? toDoNumber;
  final bool? shouldNotUseExpanded;

  const TabButton(
      {super.key,
      this.isSelected = false,
      required this.text,
      this.onPressed,
      this.toDoNumber,
      this.shouldNotUseExpanded});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    if (shouldNotUseExpanded != null && shouldNotUseExpanded == true) {
      return buildGestureDetector(themeData, context);
    }
    return Expanded(
      child: buildGestureDetector(themeData, context),
    );
  }

  GestureDetector buildGestureDetector(
      ThemeData themeData, BuildContext context) {
    final verticalPadding = toDoNumber != null ? 4.0 : 8.0;
    final horizontalPadding = toDoNumber != null ? 4.0 : 0.0;
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        height: MediaQuery.of(context).size.height * 0.045,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: isSelected
                ? Border.all(color: themeData.primaryColor, width: 1.3)
                : const Border.fromBorderSide(BorderSide.none),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 7,
                offset: const Offset(1, 2),
              ),
            ]),
        child: buildInnerText(themeData),
      ),
    );
  }

  Widget buildInnerText(ThemeData themeData) {
    final textWidget = Text(
      text,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
      textAlign: TextAlign.center,
    );
    return toDoNumber == null
        ? textWidget
        : Row(
            children: [
              Expanded(
                child: textWidget,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: ClipOval(
                  child: Container(
                    height: 30,
                    width: 30,
                    color: themeData.primaryColor,
                    child: Center(
                      child: int.parse(toDoNumber!) <= 99
                          ? Text(
                              toDoNumber!,
                              style: themeData.textTheme.bodyLarge?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            )
                          : Text(
                              "+99",
                              style: themeData.textTheme.bodyLarge?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

// Container(
// width: 40,
// height: 40,
// decoration: BoxDecoration(
// border: Border.all(width: 2),
// shape: BoxShape.circle,
// // You can use like this way or like the below line
// //borderRadius: new BorderRadius.circular(30.0),
// color: themeData.primaryColor,
// ),
// child: Text(
// toDoNumber!,
// style: themeData.textTheme.bodyText1
//     ?.copyWith(fontSize: 14, fontWeight: FontWeight.w700),
// ),
// ),
