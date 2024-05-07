// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/enums.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';

class SortOrdersDialog extends StatefulWidget {
  final List<bool>? checkboxesOldValues;
  const SortOrdersDialog({
    Key? key,
    this.checkboxesOldValues,
  }) : super(key: key);

  @override
  State<SortOrdersDialog> createState() => _SortOrdersDialogState();
}

class _SortOrdersDialogState extends State<SortOrdersDialog> {
  List<bool> checkboxesValues = [true, true, true];

  @override
  void initState() {
    super.initState();
    if (widget.checkboxesOldValues != null) {
      checkboxesValues = widget.checkboxesOldValues!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;
    return KheasydevDialog(
      height: sizeScreen * 0.2,
      primaryColor: Colors.white,
      title: appTranslate("filter_orders"),
      buttons: [
        GenericButtonModel(
            text: appTranslate('ok'),
            type: GenericButtonType.outlined,
            onPressed: () async {
              Navigator.of(context).pop(checkboxesValues);
            }),
        GenericButtonModel(
            text: appTranslate('cancel'),
            type: GenericButtonType.outlined,
            onPressed: () {
              Navigator.of(context)
                  .pop(widget.checkboxesOldValues ?? [true, true, true]);
            }),
      ],
      child: SizedBox(
        width: 0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: OrderStatus.values.length,
            itemBuilder: (context, index) => CheckboxListTile(
              value: checkboxesValues[index],
              onChanged: (value) => setState(() {
                checkboxesValues[index] = value!;
              }),
              title: Text(OrderStatusX.getAllValuesString()[index]),
            ),
          ),
        ),
      ),
    );
  }
}
