import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/general_data_source.dart';
import 'package:tzamtzam_hadar/widgets/general/network_images_loading.dart';

class ChooseImageDialog extends StatelessWidget {
  const ChooseImageDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return KheasydevDialog(
      height: 150,
      primaryColor: Colors.white,
      title: appTranslate("choose_image"),
      buttons: [
        GenericButtonModel(
            text: appTranslate('gallery'),
            type: GenericButtonType.outlined,
            onPressed: () {
              Navigator.of(context).pop(ImageSource.gallery);
            }),
        GenericButtonModel(
            text: appTranslate('camera'),
            type: GenericButtonType.outlined,
            onPressed: () {
              Navigator.of(context).pop(ImageSource.camera);
            }),
      ],
    );
  }
}
