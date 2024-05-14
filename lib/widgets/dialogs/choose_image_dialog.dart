import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';
import 'package:tzamtzam_hadar/widgets/general/network_images_loading.dart';

class ChooseImageDialog extends StatefulWidget {
  final bool qrCode;
  const ChooseImageDialog({
    required this.qrCode,
    super.key,
  });

  @override
  State<ChooseImageDialog> createState() => _ChooseImageDialogState();
}

class _ChooseImageDialogState extends State<ChooseImageDialog> {
  bool expanded = false;
  bool asGridView = false;
  @override
  Widget build(BuildContext context) {
    return KheasydevDialog(
      // height: 150,
      width: 0,
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
          },
        ),
        if (widget.qrCode == false)
          GenericButtonModel(
            text: appTranslate('symbols'),
            type: GenericButtonType.outlined,
            onPressed: () {
              setState(() {
                expanded = !expanded;
              });
            },
          ),
      ],
      child: expanded
          ? Column(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        asGridView = !asGridView;
                      });
                    },
                    icon: Icon(asGridView ? Icons.grid_on : Icons.list)),
                SizedBox(
                    height: asGridView ? 300 : 100,
                    child: asGridView ? displayGridView() : displayListView()),
                // asGridView
                //     ? displayGridView()
                //     : SizedBox(height: 120, child: displayListView()),
              ],
            )
          : null,
    );
  }

  GridView displayGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: globalIcons.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop(globalIcons.values.elementAt(index));
        },
        child: Column(
          children: [
            networkLoadingImages(globalIcons.values.elementAt(index)),
            Text(
              (appTranslate(globalIcons.keys.elementAt(index))),
            ),
          ],
        ),
      ),
    );
  }

  ListView displayListView() {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: globalIcons.length,
      separatorBuilder: (context, index) => SizedBox(width: 12),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop(globalIcons.values.elementAt(index));
        },
        child: Column(
          children: [
            SizedBox(
                child:
                    networkLoadingImages(globalIcons.values.elementAt(index))),
            Text(
              (appTranslate(globalIcons.keys.elementAt(index))),
            ),
          ],
        ),
      ),
    );
  }
}
