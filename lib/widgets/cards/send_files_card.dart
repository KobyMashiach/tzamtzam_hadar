import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/general_data_source.dart';
import 'package:tzamtzam_hadar/models/send_files_model.dart';
import 'package:tzamtzam_hadar/services/general_functions.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/info_dialog.dart';
import 'package:tzamtzam_hadar/widgets/general/network_images_loading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SendFilesCard extends StatelessWidget {
  const SendFilesCard({super.key, required this.item});

  final SendFilesModel item;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: GeneralDataSource.getPermissions().toId() <= 2,
      key: ValueKey(0),
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {}, //ToDo: delete from list
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: appTranslate('delete'),
          ),
          SlidableAction(
            onPressed: (context) {}, //ToDo: edit item
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: appTranslate('edit'),
          ),
        ],
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
              })} ${appTranslate(item.name)}"),
          leading: networkLoadingImages(item.imageUrl),
          trailing: IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => InfoDialog(
                    title: "${appTranslate("send_some_in", arguments: {
                          "type": appTranslate(item.type)
                        })} ${appTranslate(item.name)}",
                    info: appTranslate("${item.name}_send_info"),
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
