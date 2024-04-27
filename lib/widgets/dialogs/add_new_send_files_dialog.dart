import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/services/general_functions.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';
import 'package:tzamtzam_hadar/widgets/design/fields/app_dropdown.dart';
import 'package:tzamtzam_hadar/widgets/design/fields/app_textfields.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/choose_image_dialog.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/user_input_dialog.dart';

class AddNewSendFilesDialog extends StatefulWidget {
  final String title;
  final Function(Widget)? getImage;

  const AddNewSendFilesDialog({
    super.key,
    required this.title,
    this.getImage,
  });

  @override
  State<AddNewSendFilesDialog> createState() => _AddNewSendFilesDialogState();
}

class _AddNewSendFilesDialogState extends State<AddNewSendFilesDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController typeController;
  late TextEditingController networkUrlController;

  late Widget? displayImage = null;
  late Widget? displayQrCode = null;
  late XFile? image;
  late XFile? qrImage;

  //TODO: add type images / documents

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    typeController = TextEditingController();
    networkUrlController = TextEditingController();
    image = null;
    qrImage = null;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    typeController.dispose();
    networkUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;
    return KheasydevDialog(
      height: image == null && qrImage == null
          ? sizeScreen * 0.5
          : sizeScreen * 0.6,
      primaryColor: Colors.white,
      title: widget.title,
      buttons: [
        GenericButtonModel(
            text: appTranslate('ok'),
            type: GenericButtonType.outlined,
            onPressed: () async {
              if (titleController.text == "")
                kheasydevAppToast(appTranslate("please_write_title"));
              else if (descriptionController.text == "")
                kheasydevAppToast(appTranslate("please_write_description"));
              else if (networkUrlController.text == "")
                kheasydevAppToast(appTranslate("please_write_link"));
              else if (typeController.text == "")
                kheasydevAppToast(appTranslate("please_write_type"));
              else if (image == null)
                kheasydevAppToast(appTranslate("please_upload_image"));
              else
                Navigator.of(context).pop((
                  titleController.text,
                  descriptionController.text,
                  typeController.text,
                  networkUrlController.text,
                  image,
                  qrImage
                ));
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
                  controller: titleController,
                  onClear: () => titleController.clear(),
                ),
              ),
              Expanded(
                child: AppTextField(
                  onChanged: (title) {
                    descriptionController.text = title;
                  },
                  hintText: appTranslate('description'),
                  clearXIcon: true,
                  controller: descriptionController,
                  onClear: () => descriptionController.clear(),
                  textInputAction: TextInputAction.newline,
                  keyboard: TextInputType.multiline,
                  maxLinesIsNull: true,
                ),
              ),
              Expanded(
                child: AppTextField(
                  onChanged: (title) {
                    networkUrlController.text = title;
                  },
                  hintText: appTranslate('link'),
                  clearXIcon: true,
                  controller: networkUrlController,
                  onClear: () => networkUrlController.clear(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("${appTranslate('type')}:"),
                  ),
                  Expanded(
                    flex: 7,
                    child: AppDropDown(
                        onChanged: (value) {
                          if (value == globalSendFilesTypeTranslated[0]) {
                            typeController.text = globalSendFilesType[0];
                          } else {
                            typeController.text = globalSendFilesType[1];
                          }
                        },
                        listValues: globalSendFilesTypeTranslated),
                  ),
                ],
              ),
              chooseLinkOrImageRow(
                context,
                title: "choose_image",
                qrCode: false,
              ),
              chooseLinkOrImageRow(
                context,
                title: "choose_qrcode",
                qrCode: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (displayImage != null)
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: displayImage!,
                    ),
                  if (displayQrCode != null)
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: displayQrCode!,
                    ),
                ],
              ),
            ],
          )),
    );
  }

  Row chooseLinkOrImageRow(BuildContext context,
      {required String title, required bool qrCode}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("${appTranslate(title)}:"),
        ElevatedButton.icon(
          onPressed: () async {
            final userChoice = await showDialog(
              context: context,
              builder: (context) => ChooseImageDialog(),
            );
            if (userChoice != null) {
              qrCode == true
                  ? qrImage = await GeneralFunctions().chooseImage(userChoice)
                  : image = await GeneralFunctions().chooseImage(userChoice);
              qrCode == true
                  ? displayQrCode = Image.file(File(qrImage!.path))
                  : displayImage = Image.file(File(image!.path));
            }

            setState(() {});
          },
          icon: Icon(Icons.phone_iphone_outlined),
          label: Text(appTranslate("image")),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            final String? userChoice = await showDialog(
              context: context,
              builder: (context) => UserInputDialog(
                title: appTranslate("paste_link"),
                hintText: appTranslate("link"),
              ),
            );
            if (userChoice != null && userChoice != "") {
              if (qrCode == true) {
                qrImage =
                    await GeneralFunctions().getImageFileFromUrl(userChoice);
                displayQrCode = Image.file(File(qrImage!.path));
              } else {
                image =
                    await GeneralFunctions().getImageFileFromUrl(userChoice);
                displayImage = Image.file(File(image!.path));
              }
            }
            setState(() {});
          },
          icon: Icon(Icons.web),
          label: Text(appTranslate("link")),
        ),
      ],
    );
  }
}
