import 'package:flutter/material.dart';

import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';

class GeneralDialog extends StatelessWidget {
  final String title;
  final bool? noOkCancelButtons;
  final Widget? child;

  const GeneralDialog({
    super.key,
    required this.title,
    this.noOkCancelButtons,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return KheasydevDialog(
      primaryColor: Colors.white,
      title: title,
      buttons: noOkCancelButtons == true
          ? []
          : [
              GenericButtonModel(
                  text: appTranslate('ok'),
                  type: GenericButtonType.outlined,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  }),
              GenericButtonModel(
                text: appTranslate('cancel'),
                type: GenericButtonType.outlined,
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
      child: child,
    );
  }
}
