import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/screens/permission_login/permission_login.dart';
import 'package:tzamtzam_hadar/screens/send_files/bloc/send_files_bloc.dart';
import 'package:tzamtzam_hadar/widgets/cards/send_files_card.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';
import 'package:tzamtzam_hadar/widgets/general/side_menu.dart';

class SendFiles extends StatelessWidget {
  const SendFiles({super.key});

  @override
  Widget build(BuildContext context) {
    //ToDo: CachedNetworkImage
    return BlocProvider(
      create: (context) => SendFilesBloc()..add(SendFilesEventInit()),
      child: BlocConsumer<SendFilesBloc, SendFilesState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: appAppBar(
                title: appTranslate(context, 'send_files'),
                developerPage: PermissionLogin(),
                context: context),
            drawer: appSideMenu(context, index: 0),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    appTranslate(context, 'send_files'),
                    style: AppTextStyle().title,
                  ),
                  kheasydevDivider(black: true),
                  SizedBox(height: 24),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.sendFilesList.length,
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = state.sendFilesList[index];
                      return SendFilesCard(item: item);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
