import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/screens/managment/bloc/managment_bloc.dart';
import 'package:tzamtzam_hadar/widgets/cards/general_card.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/add_new_send_files_dialog.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';
import 'package:tzamtzam_hadar/widgets/general/side_menu.dart';

class Managment extends StatelessWidget {
  const Managment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManagmentBloc()..add(ManagmentEventInit()),
      child: BlocConsumer<ManagmentBloc, ManagmentState>(
        listenWhen: (previous, current) => current is ManagmentNavigationState,
        buildWhen: (previous, current) => current is! ManagmentNavigationState,
        listener: (context, state) async {
          final bloc = context.read<ManagmentBloc>();
          switch (state.runtimeType) {
            case const (ManagmentNavigationOpenSendFilesDialog):
              final newState = state as ManagmentNavigationOpenSendFilesDialog;
              final sendFilesData = await showDialog(
                context: context,
                builder: (context) => AddNewSendFilesDialog(
                    title: newState.managmentList[state.index]),
              );
          }
        },
        builder: (context, state) {
          final bloc = context.read<ManagmentBloc>();
          return Scaffold(
            appBar: appAppBar(title: appTranslate('managment')),
            drawer: appSideMenu(context, index: 0),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    appTranslate('managment'),
                    style: AppTextStyle().title,
                  ),
                  kheasydevDivider(black: true),
                  SizedBox(height: 24),
                  // AppDropDown(
                  //   onChanged: (value) {},
                  //   listValues: state.managmentList,
                  //   hintText: appTranslate("key"),
                  // )
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.managmentList.length,
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = state.managmentList[index];
                      return GeneralCard(
                        title: item,
                        centerTitle: true,
                        onTap: () => bloc.add(ManagmentEventOpenDialog(index)),
                      ); //AddNewSendFilesDialog
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
