// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class AddEditSendFilesDialog extends StatefulWidget {
  final String pageTitle;

  final String? title;
  final String? description;
  final String? type;
  final String? networkUrl;
  final XFile? oldImage;
  final XFile? oldQrImage;
  final bool? emailLink;

  const AddEditSendFilesDialog({
    Key? key,
    required this.pageTitle,
    this.title,
    this.description,
    this.type,
    this.networkUrl,
    this.oldImage,
    this.oldQrImage,
    this.emailLink,
  }) : super(key: key);

  @override
  State<AddEditSendFilesDialog> createState() => _AddEditSendFilesDialogState();
}

class _AddEditSendFilesDialogState extends State<AddEditSendFilesDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController typeController;
  late TextEditingController networkUrlController;

  late Widget? displayImage = null;
  late Widget? displayQrCode = null;
  late XFile? image;
  late XFile? qrImage;
  late bool? emailLink;

  @override
  void initState() {
    super.initState();
    initControllersAndImages();
    initDialogEditItem();
  }

  void initDialogEditItem() async {
    if (widget.title != null && widget.title != "")
      titleController.text = widget.title!;
    if (widget.description != null && widget.description != "")
      descriptionController.text = widget.description!;
    if (widget.type != null && widget.type != "")
      typeController.text = widget.type!;
    if (widget.networkUrl != null && widget.networkUrl != "") {
      networkUrlController.text = widget.networkUrl!;
      if (networkUrlController.text.startsWith("mailto:")) {
        networkUrlController.text =
            networkUrlController.text.replaceAll("mailto:", "");
      }
    }
    if (widget.oldImage != null) {
      image = widget.oldImage;
      displayImage = Image.file(File(image!.path));
    }
    if (widget.oldQrImage != null) {
      qrImage = widget.oldQrImage;
      displayQrCode = Image.file(File(qrImage!.path));
    }
    if (widget.emailLink != null) emailLink = widget.emailLink;
  }

  void initControllersAndImages() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    typeController = TextEditingController();
    networkUrlController = TextEditingController();
    image = null;
    qrImage = null;
    emailLink = false;
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
      title: widget.pageTitle,
      buttons: [
        GenericButtonModel(
            text: appTranslate('ok'),
            type: GenericButtonType.outlined,
            onPressed: () async {
              onSaveSendFilesDialog(context);
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
                  child: textControllersRows(
                      title: "title", controller: titleController)),
              Expanded(
                  child: textControllersRows(
                      title: "description",
                      controller: descriptionController,
                      description: true)),
              Expanded(
                  child: textControllersRows(
                      title: emailLink == true ? "email" : "link",
                      controller: networkUrlController,
                      link: true)),
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
                        hintText: appTranslate("type"),
                        value: widget.type != null
                            ? appTranslate(widget.type!)
                            : null,
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

  void onSaveSendFilesDialog(BuildContext context) {
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
    else {
      if (emailLink == true &&
          !networkUrlController.text.startsWith("mailto:")) {
        networkUrlController.text = "mailto:${networkUrlController.text}";
      } else if (emailLink == false &&
          networkUrlController.text.startsWith("mailto:")) {
        networkUrlController.text =
            networkUrlController.text.replaceAll("mailto:", "");
      }
      Navigator.of(context).pop((
        titleController.text,
        descriptionController.text,
        typeController.text,
        networkUrlController.text,
        image,
        qrImage,
        emailLink,
      ));
    }
  }

  Row textControllersRows(
      {required String title,
      required TextEditingController controller,
      bool? description,
      bool? link}) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text("${appTranslate(title)}:")),
        if (link == true)
          CheckboxMenuButton(
            value: emailLink,
            onChanged: (value) {
              emailLink = value;
              setState(() {});
            },
            child: Text(""),
          ),
        Expanded(
          flex: 8,
          child: AppTextField(
            padding: EdgeInsets.all(0),
            onChanged: (value) => controller.text = value,
            hintText: appTranslate(title),
            clearXIcon: true,
            controller: controller,
            onClear: () => controller.clear(),
            textInputAction:
                description == true ? TextInputAction.newline : null,
            keyboard: description == true ? TextInputType.multiline : null,
            maxLinesIsNull: description == true ? true : null,
          ),
        ),
      ],
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
              builder: (context) => ChooseImageDialog(qrCode: qrCode),
            );
            if (userChoice != null) {
              if (userChoice is String) {
                await imageFromString(qrCode, userChoice);
              } else {
                qrCode == true
                    ? qrImage = await GeneralFunctions().chooseImage(userChoice)
                    : image = await GeneralFunctions().chooseImage(userChoice);
                qrCode == true
                    ? displayQrCode = Image.file(File(qrImage!.path))
                    : displayImage = Image.file(File(image!.path));
              }
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
              await imageFromString(qrCode, userChoice);
            }
            setState(() {});
          },
          icon: Icon(Icons.web),
          label: Text(appTranslate("link")),
        ),
      ],
    );
  }

  Future<void> imageFromString(bool qrCode, String userChoice) async {
    if (qrCode == true) {
      qrImage = await GeneralFunctions().getImageFileFromUrl(userChoice);
      displayQrCode = Image.file(File(qrImage!.path));
    } else {
      image = await GeneralFunctions().getImageFileFromUrl(userChoice);
      displayImage = Image.file(File(image!.path));
    }
  }
}
