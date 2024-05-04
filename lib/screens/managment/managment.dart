import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:kh_easy_dev/widgets/navigate_page.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/lists_maps_data_source.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';
import 'package:tzamtzam_hadar/repos/lists_maps_repo.dart';
import 'package:tzamtzam_hadar/repos/orders_repo.dart';
import 'package:tzamtzam_hadar/repos/send_files_repo.dart';
import 'package:tzamtzam_hadar/screens/contacts/contacts_screen.dart';
import 'package:tzamtzam_hadar/screens/managment/bloc/managment_bloc.dart';
import 'package:tzamtzam_hadar/widgets/cards/general_card.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/add_edit_send_files_dialog.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';
import 'package:tzamtzam_hadar/widgets/general/side_menu.dart';

class Managment extends StatelessWidget {
  const Managment({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OrdersDataSource>(
          create: (context) => OrdersDataSource(),
        ),
        RepositoryProvider<OrdersRepo>(
          create: (context) => OrdersRepo(context.read<OrdersDataSource>()),
        ),
        RepositoryProvider<ListsMapsDataSource>(
          create: (context) => ListsMapsDataSource(),
        ),
        RepositoryProvider<ListsMapsRepo>(
          create: (context) =>
              ListsMapsRepo(context.read<ListsMapsDataSource>()),
        ),
        RepositoryProvider<SendFilesRepo>(create: (context) => SendFilesRepo()),
      ],
      child: BlocProvider(
        create: (context) => ManagmentBloc(
            orderRepo: context.read<OrdersRepo>(),
            listsMapsRepo: context.read<ListsMapsRepo>(),
            sendFilesRepo: context.read<SendFilesRepo>())
          ..add(ManagmentEventInit()),
        child: BlocConsumer<ManagmentBloc, ManagmentState>(
          listenWhen: (previous, current) =>
              current is ManagmentNavigationState,
          buildWhen: (previous, current) =>
              current is! ManagmentNavigationState,
          listener: (context, state) async {
            final bloc = context.read<ManagmentBloc>();
            switch (state.runtimeType) {
              case const (ManagmentNavigationOpenSendFilesDialog):
                final newState =
                    state as ManagmentNavigationOpenSendFilesDialog;
                final sendFilesData = await showDialog(
                  context: context,
                  builder: (context) => AddEditSendFilesDialog(
                      pageTitle: newState.managmentList[state.index]),
                );
                bloc.add(ManagmentEventAddNewSendFilesItem(
                  title: sendFilesData.$1,
                  description: sendFilesData.$2,
                  type: sendFilesData.$3,
                  networkUrl: sendFilesData.$4,
                  image: sendFilesData.$5,
                  qrImage: sendFilesData.$6,
                  emailLink: sendFilesData.$7,
                ));
              //  if(sendFilesData!= null){bloc.add(event)}
              case const (ManagmentNavigationOpenDeleteAllOrdersDialog):
                await deleteAllOrdersDialog(context, bloc);
              case const (ManagmentNavigationNavToContactsPage):
                KheasydevNavigatePage().push(context, ContactsScreen());
            }
          },
          builder: (context, state) {
            final bloc = context.read<ManagmentBloc>();
            return Scaffold(
              appBar: appAppBar(title: appTranslate('managment')),
              drawer: appSideMenu(context, index: 2),
              body: state is ManagmentStateLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(
                            appTranslate('managment'),
                            style: AppTextStyle().title,
                          ),
                          kheasydevDivider(black: true),
                          SizedBox(height: 24),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.managmentList.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final item = state.managmentList[index];
                              return GeneralCard(
                                title: item,
                                centerTitle: true,
                                onTap: () =>
                                    bloc.add(ManagmentEventOpenDialog(index)),
                              ); //AddNewSendFilesDialog
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

  Future<dynamic> deleteAllOrdersDialog(
      BuildContext context, ManagmentBloc bloc) {
    return showDialog(
      context: context,
      builder: (context) => KheasydevDialog(
        title: appTranslate("are_you_sure"),
        descriptions: [
          appTranslate("delete_all_orders_description"),
          appTranslate("no_recovery_orders")
        ],
        primaryColor: AppColor.primaryColor,
        buttons: [
          GenericButtonModel(
              text: appTranslate("no"),
              type: GenericButtonType.outlined,
              onPressed: () {
                Navigator.of(context).pop();
              }),
          GenericButtonModel(
              text: appTranslate("yes"),
              type: GenericButtonType.outlined,
              onPressed: () {
                bloc.add(ManagmentEventClearOrders());
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
