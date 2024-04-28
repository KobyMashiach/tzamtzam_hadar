import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/lists_maps_data_source.dart';
import 'package:tzamtzam_hadar/models/send_files_model.dart';
import 'package:tzamtzam_hadar/repos/lists_maps_repo.dart';
import 'package:tzamtzam_hadar/screens/permission_login/permission_login.dart';
import 'package:tzamtzam_hadar/screens/send_files/bloc/send_files_bloc.dart';
import 'package:tzamtzam_hadar/services/general_functions.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';
import 'package:tzamtzam_hadar/widgets/cards/send_files_card.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/add_edit_send_files_dialog.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';
import 'package:tzamtzam_hadar/widgets/general/side_menu.dart';

class SendFiles extends StatelessWidget {
  const SendFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ListsMapsDataSource>(
          create: (context) => ListsMapsDataSource(),
        ),
        RepositoryProvider<ListsMapsRepo>(
          create: (context) =>
              ListsMapsRepo(context.read<ListsMapsDataSource>()),
        ),
      ],
      child: BlocProvider(
        create: (context) => SendFilesBloc(context.read<ListsMapsRepo>())
          ..add(SendFilesEventInit()),
        child: BlocConsumer<SendFilesBloc, SendFilesState>(
          listenWhen: (previous, current) => current is SendFilesNavigatorState,
          buildWhen: (previous, current) => current is! SendFilesNavigatorState,
          listener: (context, state) async {
            final bloc = context.read<SendFilesBloc>();
            switch (state.runtimeType) {
              case const (SendFilesOpenEditDialog):
                final newState = state as SendFilesOpenEditDialog;
                final SendFilesModel item = newState.item;
                bloc.add(SendFilesOnLoadingScreen());
                final oldImage =
                    await GeneralFunctions().getImageFileFromUrl(item.imageUrl);
                final oldQrImage = item.qrCode != null && item.qrCode != ""
                    ? await GeneralFunctions().getImageFileFromUrl(item.qrCode!)
                    : null;
                bloc.add(SendFilesOnDoneLoading());
                final sendFilesData = await showDialog(
                  context: context,
                  builder: (context) => AddEditSendFilesDialog(
                    pageTitle: globalManagmentCategoriesTranslated[0],
                    title: item.name,
                    description: item.description,
                    networkUrl: item.networkUrl,
                    type: item.type,
                    oldImage: oldImage,
                    oldQrImage: oldQrImage,
                    emailLink: item.emailLink,
                  ),
                );
                if (sendFilesData != null) {
                  bloc.add(SendFilesOnSaveEditItem(
                    title: sendFilesData.$1,
                    description: sendFilesData.$2,
                    type: sendFilesData.$3,
                    networkUrl: sendFilesData.$4,
                    image: sendFilesData.$5,
                    qrImage: sendFilesData.$6,
                    oldTitle: item.name,
                    emailLink: sendFilesData.$7,
                  ));
                }
            }
          },
          builder: (context, state) {
            final bloc = context.read<SendFilesBloc>();
            return Scaffold(
              appBar: appAppBar(
                  title: appTranslate('send_files'),
                  developerPage: PermissionLogin(),
                  context: context),
              drawer: appSideMenu(context, index: 0),
              body: state is SendFilesLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(
                            appTranslate('send_files'),
                            style: AppTextStyle().title,
                          ),
                          kheasydevDivider(black: true),
                          SizedBox(height: 24),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.sendFilesList.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final item = state.sendFilesList[index];
                              return SendFilesCard(
                                item: item,
                                onDelete: (context) =>
                                    bloc.add(SendFilesOnDeleteItem(item: item)),
                                onEdit: (context) =>
                                    bloc.add(SendFilesOnEditItem(item: item)),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
