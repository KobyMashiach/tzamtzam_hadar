import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tzamtzam_hadar/core/colors.dart';

class ContactCard extends StatelessWidget {
  const ContactCard(
      {super.key,
      required this.name,
      required this.phoneNumber,
      required this.onPhonePress,
      required this.onWhatsappPress});

  final String name;
  final String phoneNumber;
  final VoidCallback onPhonePress;
  final VoidCallback onWhatsappPress;

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
          "$name: $phoneNumber",
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.phone, size: 30),
          onPressed: onPhonePress,
        ),
        trailing: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/whatsapp.svg',
            colorFilter: ColorFilter.mode(Colors.green, BlendMode.srcIn),
            height: 30,
            width: 30,
          ),
          onPressed: onWhatsappPress,
        ),
      ),
    );
  }
}
