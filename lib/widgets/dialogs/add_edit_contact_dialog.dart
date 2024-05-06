import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';

import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';
import 'package:tzamtzam_hadar/widgets/design/fields/app_dropdown.dart';
import 'package:tzamtzam_hadar/widgets/design/fields/app_textfields.dart';

class AddEditContactDialog extends StatefulWidget {
  final String? name;
  final String? phoneNumber;
  final String? group;
  const AddEditContactDialog(
      {Key? key, this.name, this.phoneNumber, this.group})
      : super(key: key);

  @override
  State<AddEditContactDialog> createState() => _AddEditContactDialogState();
}

class _AddEditContactDialogState extends State<AddEditContactDialog> {
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  late TextEditingController groupController;

  @override
  void initState() {
    super.initState();
    initControllers();
    initControllersHaveData();
  }

  void initControllers() {
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    groupController = TextEditingController();
  }

  void initControllersHaveData() {
    if (widget.name != null) nameController.text = widget.name!;
    if (widget.phoneNumber != null)
      phoneNumberController.text = widget.phoneNumber!;
    if (widget.group != null) groupController.text = widget.group!;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    groupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;
    return KheasydevDialog(
      height: sizeScreen * 0.35,
      primaryColor: Colors.white,
      title: appTranslate("contacts"),
      buttons: [
        GenericButtonModel(
            text: appTranslate('ok'),
            type: GenericButtonType.outlined,
            onPressed: () async {
              onSaveContact(context);
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
            ElevatedButton.icon(
              onPressed: () async {
                final PhoneContact contact =
                    await FlutterContactPicker.pickPhoneContact();
                nameController.text = contact.fullName ?? "";
                phoneNumberController.text = contact.phoneNumber?.number ?? "";
              },
              label: Text("בחר מאנשי הקשר"),
              icon: Icon(Icons.add),
            ),
            Expanded(
                child: textControllersRows(
                    title: "name", controller: nameController)),
            Expanded(
                child: textControllersRows(
              title: "phone_number",
              controller: phoneNumberController,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: Text("${appTranslate('group')}:"),
                ),
                Expanded(
                  flex: 7,
                  child: AppDropDown(
                      value: widget.group != null
                          ? appTranslate(widget.group!)
                          : null,
                      hintText: appTranslate("group"),
                      onChanged: (value) {
                        onChangeGroupDrpoDown(value);
                      },
                      listValues: globalContactsListTranslated.keys.toList()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onChangeGroupDrpoDown(String value) {
    final noTranslatedKeys = globalContactsList.keys.toList();
    final translatedKeys = globalContactsListTranslated.keys.toList();
    if (value == translatedKeys[0]) {
      groupController.text = noTranslatedKeys[0];
    } else if (value == translatedKeys[1]) {
      groupController.text = noTranslatedKeys[1];
    } else if (value == translatedKeys[2]) {
      groupController.text = noTranslatedKeys[2];
    } else {
      groupController.text = noTranslatedKeys[3];
    }
  }

  void onSaveContact(BuildContext context) {
    if (nameController.text == "")
      kheasydevAppToast(appTranslate("please_write_name"));
    else if (phoneNumberController.text == "")
      kheasydevAppToast(appTranslate("please_write_phone_number"));
    else if (phoneValidation(phoneNumberController.text))
      kheasydevAppToast(appTranslate("wrong_phone_number"));
    else if (groupController.text == "")
      kheasydevAppToast(appTranslate("please_write_group"));
    else {
      Navigator.of(context).pop((
        nameController.text,
        phoneNumberController.text,
        groupController.text,
      ));
    }
  }

  Row textControllersRows({
    required String title,
    required TextEditingController controller,
  }) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text("${appTranslate(title)}:")),
        Expanded(
          flex: 8,
          child: AppTextField(
            padding: EdgeInsets.all(0),
            onChanged: (value) => controller.text = value,
            hintText: appTranslate(title),
            clearXIcon: true,
            controller: controller,
            onClear: () => controller.clear(),
          ),
        ),
      ],
    );
  }
}

bool phoneValidation(String input) {
  input = input.replaceAll('-', '');
  if (!input.startsWith('+972') && input.length == 10) {
    return false;
  } else if (input.startsWith('+972') && input.length == 13) {
    return false;
  } else {
    return true;
  }
}
