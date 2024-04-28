import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/services/general_subwidgets.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.onPhonePress,
    required this.onWhatsappPress,
    this.onDelete,
  });

  final String name;
  final String phoneNumber;
  final VoidCallback onPhonePress;
  final VoidCallback onWhatsappPress;
  final dynamic Function(BuildContext)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(2),
      startActionPane: GeneralSubwidgets().slidableGeneralActionPane(
        onDelete: onDelete,
      ),
      child: Container(
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
      ),
    );
  }
}
