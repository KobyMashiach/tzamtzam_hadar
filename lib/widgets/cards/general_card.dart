import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/colors.dart';

class GeneralCard extends StatelessWidget {
  const GeneralCard(
      {super.key, required this.title, this.onTap, this.centerTitle});

  final String title;
  final bool? centerTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: AppColor.primaryColor,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3)),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          textAlign: centerTitle == true ? TextAlign.center : null,
        ),
        onTap: onTap,
      ),
    );
  }
}
