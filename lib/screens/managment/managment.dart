import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';
import 'package:tzamtzam_hadar/widgets/general/side_menu.dart';

class Managment extends StatelessWidget {
  const Managment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(
        title: appTranslate(context, 'managment'),
      ),
      drawer: appSideMenu(context, index: 0),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              appTranslate(context, 'managment'),
              style: AppTextStyle().title,
            ),
            kheasydevDivider(black: true),
            SizedBox(height: 24),
            // ListView.separated(
            //   shrinkWrap: true,
            //   itemCount: state.sendFilesList.length,
            //   separatorBuilder: (context, index) => SizedBox(height: 16),
            //   itemBuilder: (context, index) {
            //     final item = state.sendFilesList[index];
            //     return SendFilesCard(item: item);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
