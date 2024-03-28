import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/services/general_functions.dart';
import 'package:tzamtzam_hadar/widgets/design/fields/app_textfields.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/choose_image_dialog.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/user_input_dialog.dart';

class AddNewSendFilesDialog extends StatefulWidget {
  final String title;
  const AddNewSendFilesDialog({
    super.key,
    required this.title,
  });

  @override
  State<AddNewSendFilesDialog> createState() => _AddNewSendFilesDialogState();
}

class _AddNewSendFilesDialogState extends State<AddNewSendFilesDialog> {
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KheasydevDialog(
      height: 300,
      primaryColor: Colors.white,
      title: widget.title,
      buttons: [
        GenericButtonModel(
            text: appTranslate('ok'),
            type: GenericButtonType.outlined,
            onPressed: () async {
              Navigator.of(context).pop();
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
          child: Column(
            children: [
              Expanded(
                child: AppTextField(
                  onChanged: (title) {
                    titleController.text = title;
                  },
                  hintText: appTranslate('title'),
                  clearXIcon: true,
                  xIconHalf: true,
                  controller: titleController,
                  onClear: () => titleController.clear(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("${appTranslate("choose_image")}:"),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final userChoice = await showDialog(
                        context: context,
                        builder: (context) => ChooseImageDialog(),
                      );
                      final image = GeneralFunctions().chooseImage(userChoice);
                    },
                    icon: Icon(Icons.phone_iphone_outlined),
                    label: Text(appTranslate("image")),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final userChoice = await showDialog(
                        context: context,
                        builder: (context) => UserInputDialog(
                          title: appTranslate("paste_link"),
                          hintText: appTranslate("link"),
                        ),
                      );
                    },
                    icon: Icon(Icons.web),
                    label: Text(appTranslate("link")),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
