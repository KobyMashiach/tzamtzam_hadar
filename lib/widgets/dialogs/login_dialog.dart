import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/general_data_source.dart';
import 'package:tzamtzam_hadar/models/user_permissions.dart';
import 'package:tzamtzam_hadar/services/general_data.dart';
import 'package:tzamtzam_hadar/widgets/design/fields/app_textfields.dart';

class LoginDialog extends StatelessWidget {
  final UserPermissions permission;
  const LoginDialog({
    super.key,
    required this.permission,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordInput = TextEditingController();
    return KheasydevDialog(
      height: 150,
      primaryColor: Colors.white,
      title:
          "${appTranslate(context, 'login')} ${permission.getString(context)}",
      buttons: [
        GenericButtonModel(
            text: appTranslate(context, 'ok'),
            type: GenericButtonType.outlined,
            onPressed: () async {
              if (passwordInput.text == permissionPassword(permission)) {
                await GeneralDataSource.savePermissions(key: permission);
                kheasydevAppToast(appTranslate(context, 'login_successfuly_to',
                    arguments: {"permission": permission.getString(context)}));
                Navigator.of(context).pop();
              } else {
                kheasydevAppToast(appTranslate(context, 'wrong_password'));
              }
            }),
        GenericButtonModel(
            text: appTranslate(context, 'cancel'),
            type: GenericButtonType.outlined,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: AppTextField(
          onChanged: (password) {
            passwordInput.text = password;
          },
          hintText: appTranslate(context, 'password'),
          clearXIcon: true,
          controller: passwordInput,
          onClear: () => passwordInput.clear(),
        ),
      ),
    );
  }
}
