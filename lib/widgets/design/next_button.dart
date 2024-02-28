import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/colors.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.onTapDisable,
    this.disabled = false,
    this.disabledColor = const Color.fromARGB(255, 201, 201, 201),
  });

  final Function() onTap;
  final Function()? onTapDisable;
  final IconData icon;
  final bool disabled;
  final Color disabledColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? onTapDisable : onTap,
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.primaryColor, width: 4),
          shape: BoxShape.circle,
          color: disabled ? disabledColor : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: disabled ? Colors.black45 : Colors.black,
          size: 100,
        ),
      ),
    );
  }
}
