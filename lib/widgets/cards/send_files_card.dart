import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/general_data_source.dart';
import 'package:tzamtzam_hadar/models/send_files_model.dart';
import 'package:tzamtzam_hadar/services/general_functions.dart';
import 'package:tzamtzam_hadar/services/general_subwidgets.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/info_dialog.dart';
import 'package:tzamtzam_hadar/widgets/general/network_images_loading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SendFilesCard extends StatelessWidget {
  const SendFilesCard(
      {super.key, required this.item, this.onDelete, this.onEdit});

  final SendFilesModel item;
  final dynamic Function(BuildContext)? onDelete;
  final dynamic Function(BuildContext)? onEdit;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: GeneralDataSource.getPermissions().toId() <= 2,
      key: ValueKey(0),
      startActionPane: GeneralSubwidgets().slidableGeneralActionPane(
        onDelete: onDelete,
        onEdit: onEdit,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: AppColor.primaryColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3)),
          ],
        ),
        child: ListTile(
          title: Text("${appTranslate("send_some_in", arguments: {
                "type": appTranslate(item.type)
              })} ${appTranslate(item.name) != "wrong key" ? appTranslate(item.name) : item.name}"),
          leading: networkLoadingImages(item.imageUrl),
          trailing: IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => InfoDialog(
                    title: "${appTranslate("send_some_in", arguments: {
                          "type": appTranslate(item.type)
                        })} ${appTranslate(item.name) != "wrong key" ? appTranslate(item.name) : item.name}",
                    info: item.description,
                    // info: appTranslate("${item.name}_send_info"),
                    imageUrl: item.imageUrl,
                    qrCode: item.qrCode),
              );
            },
            icon: Icon(Icons.info),
          ),
          onTap: () => GeneralFunctions().openWeb(item.networkUrl),
        ),
      ),
    );
  }
}
