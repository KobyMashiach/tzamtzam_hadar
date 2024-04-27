import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/widgets/design/fields/app_textfields.dart';

class UserInputDialog extends StatelessWidget {
  final String title;
  final String hintText;
  const UserInputDialog(
      {super.key, required this.title, required this.hintText});

  @override
  Widget build(BuildContext context) {
    TextEditingController textInput = TextEditingController();
    return KheasydevDialog(
      height: 150,
      primaryColor: Colors.white,
      title: title,
      buttons: [
        GenericButtonModel(
            text: appTranslate('ok'),
            type: GenericButtonType.outlined,
            onPressed: () async {
              Navigator.of(context).pop(textInput.text);
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
        child: AppTextField(
          onChanged: (password) {
            textInput.text = password;
          },
          hintText: hintText,
          clearXIcon: true,
          controller: textInput,
          onClear: () => textInput.clear(),
        ),
      ),
    );
  }
}
