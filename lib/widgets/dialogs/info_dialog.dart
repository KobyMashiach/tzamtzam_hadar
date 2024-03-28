import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/widgets/general/network_images_loading.dart';

class InfoDialog extends StatelessWidget {
  final String title;
  final String info;
  final String imageUrl;
  final String? qrCode;
  const InfoDialog(
      {super.key,
      required this.title,
      required this.info,
      required this.imageUrl,
      this.qrCode});

  @override
  Widget build(BuildContext context) {
    return KheasydevDialog(
      primaryColor: Colors.white,
      title: title,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Icon(Icons.info),
                SizedBox(height: 12),
                Text(info, textAlign: TextAlign.center),
              ],
            ),
            networkLoadingImages(imageUrl),
            if (qrCode != null) networkLoadingImages(qrCode!, size: 200)
          ],
        ),
      ),
    );
  }
}
