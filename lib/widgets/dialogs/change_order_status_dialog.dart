// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/enums.dart';

import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/widgets/design/fields/app_dropdown.dart';

class ChangeOrderStatusDialog extends StatefulWidget {
  final String status;
  const ChangeOrderStatusDialog({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  State<ChangeOrderStatusDialog> createState() =>
      _ChangeOrderStatusDialogState();
}

class _ChangeOrderStatusDialogState extends State<ChangeOrderStatusDialog> {
  late TextEditingController statusController;

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  void initControllers() {
    statusController = TextEditingController();
  }

  @override
  void dispose() {
    statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;
    return KheasydevDialog(
      height: sizeScreen * 0.1,
      primaryColor: Colors.white,
      title: appTranslate("change_status"),
      buttons: [
        GenericButtonModel(
            text: appTranslate('ok'),
            type: GenericButtonType.outlined,
            onPressed: () async {
              Navigator.of(context).pop(statusController.text);
            }),
        GenericButtonModel(
            text: appTranslate('cancel'),
            type: GenericButtonType.outlined,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: AppDropDown(
            hintText: appTranslate("status"),
            value: appTranslate(widget.status),
            onChanged: (value) {
              if (value == OrderStatus.done.getString()) {
                statusController.text = OrderStatus.done.getStringToFirestore();
              } else if (value == OrderStatus.hold.getString()) {
                statusController.text = OrderStatus.hold.getStringToFirestore();
              } else {
                statusController.text =
                    OrderStatus.progress.getStringToFirestore();
              }
            },
            listValues: OrderStatusX.getAllValuesString()),
      ),
    );
  }
}
