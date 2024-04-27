import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:kh_easy_dev/widgets/navigate_page.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/general_data_source.dart';
import 'package:tzamtzam_hadar/models/user_permissions.dart';
import 'package:tzamtzam_hadar/screens/send_files/send_files.dart';
import 'package:tzamtzam_hadar/widgets/cards/general_card.dart';
import 'package:tzamtzam_hadar/widgets/design/buttons/next_button.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/login_dialog.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

class PermissionLogin extends StatelessWidget {
  const PermissionLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardDisable = MediaQuery.of(context).viewInsets.bottom == 0;

    return Scaffold(
      appBar: appAppBar(
          title: appTranslate('choose_permissions'),
          onBackButtonPreesed: () {
            KheasydevNavigatePage().pushAndRemoveUntil(context, SendFiles());
          }),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    appTranslate('choose_permissions'),
                    style: AppTextStyle().title,
                  ),
                  kheasydevDivider(black: true),
                  SizedBox(height: 24),
                  SizedBox(
                    height: screenHeight / 2,
                    child: ListView.separated(
                        itemCount: UserPermissions.values.length - 1,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final permission = UserPermissions.values[index + 1];
                          return GeneralCard(
                            title: permission.getString(context),
                            centerTitle: true,
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return LoginDialog(permission: permission);
                                },
                              );
                            },
                          );
                        }),
                  ),
                  if (keyboardDisable) ...[
                    kheasydevDivider(black: true),
                    Text(
                        "${appTranslate('current_permission')}: ${GeneralDataSource.getPermissions().getString(context)}"),
                  ]
                ],
              ),
            ),
            if (keyboardDisable)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: NextButton(
                  onLongTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return LoginDialog(
                            permission: UserPermissions.developer);
                      },
                    );
                  },
                  onTap: () async {},
                  icon: Icons.done,
                ),
              )
          ],
        ),
      ),
    );
  }
}
