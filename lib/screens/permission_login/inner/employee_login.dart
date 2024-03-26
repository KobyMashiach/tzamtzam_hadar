import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:kh_easy_dev/widgets/navigate_page.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/general_data_source.dart';
import 'package:tzamtzam_hadar/models/user_permissions.dart';
import 'package:tzamtzam_hadar/services/general_data.dart';
import 'package:tzamtzam_hadar/widgets/design/buttons/next_button.dart';
import 'package:tzamtzam_hadar/widgets/design/fields/app_textfields.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

class EmployeeLogin extends StatelessWidget {
  const EmployeeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    String password = "";
    return Scaffold(
        appBar: appAppBar(title: appTranslate(context, "employee_login")),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      appTranslate(context, 'write_password'),
                      style: AppTextStyle().title,
                    ),
                    kheasydevDivider(black: true),
                    SizedBox(height: screenHeight / 10),
                    AppTextField(
                      hintText: appTranslate(context, 'password'),
                      keyboard: TextInputType.number,
                      onChanged: (value) {
                        password = value;
                      },
                    )
                  ],
                ),
              ),
              // if (keyboardDisable)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: NextButton(
                  onTap: () async {
                    if (password ==
                        permissionPassword(UserPermissions.employees)) {
                      await GeneralDataSource.savePermissions(
                          key: UserPermissions.employees);
                      KheasydevNavigatePage().pop(context);
                    } else {
                      kheasydevAppToast(
                          appTranslate(context, 'wrong_password'));
                    }
                  },
                  icon: Icons.done,
                ),
              )
            ],
          ),
        ));
  }
}
