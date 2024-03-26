import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/models/user_permissions.dart';

class PermissionsCard extends StatelessWidget {
  const PermissionsCard({super.key, required this.permission, this.onTap});
  final UserPermissions permission;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          decoration: const BoxDecoration(color: AppColor.primaryColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      permission.getString(context),
                      style: AppTextStyle().cardTitle.copyWith(fontSize: 32),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
