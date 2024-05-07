import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kh_easy_dev/widgets/navigate_page.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/repos/contacts_repo.dart';
import 'package:tzamtzam_hadar/repos/orders_repo.dart';
import 'package:tzamtzam_hadar/screens/orders_managment/orders_managment_inner/bloc/order_managment_inner_bloc.dart';
import 'package:tzamtzam_hadar/tests/print_test.dart';
import 'package:tzamtzam_hadar/widgets/cards/order_managment_card.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/add_edit_contact_dialog.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/change_order_status_dialog.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/general_dialog.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/sort_orders_dialog.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

class OrderManagment extends StatelessWidget {
  const OrderManagment({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OrdersDataSource>(
          create: (context) => OrdersDataSource(),
        ),
        RepositoryProvider<OrdersRepo>(
          create: (context) => OrdersRepo(context.read<OrdersDataSource>()),
        ),
        RepositoryProvider<ContactsRepo>(
          create: (context) => ContactsRepo(),
        ),
      ],
      child: BlocProvider(
        create: (context) => OrderManagmentInnerBloc(
          context.read<OrdersRepo>(),
          context.read<ContactsRepo>(),
        )..add(OrderManagmentEventInitial()),
        child: BlocConsumer<OrderManagmentInnerBloc, OrderManagmentInnerState>(
          listenWhen: (previous, current) =>
              current is OrderManagmentNavigatorState,
          buildWhen: (previous, current) =>
              current is! OrderManagmentNavigatorState,
          listener: (context, state) async {
            final bloc = context.read<OrderManagmentInnerBloc>();
            switch (state.runtimeType) {
              case const (OrderManagmentChangeStatusDialog):
                final newState = state as OrderManagmentChangeStatusDialog;
                final status = await showDialog(
                  context: context,
                  builder: (context) => ChangeOrderStatusDialog(
                    status: newState.order.status,
                  ),
                );
                if (status != null)
                  bloc.add(OrderManagmentEventChangeOrderStatus(
                      order: newState.order, status: status));
              case const (OrderManagmentOpenPrintDialog):
                final newState = state as OrderManagmentOpenPrintDialog;
                KheasydevNavigatePage()
                    .push(context, PrintTest(newState.order));
              case const (OrderManagmentOpenAddContactDialog):
                final newState = state as OrderManagmentOpenAddContactDialog;
                final contactData = await showDialog(
                  context: context,
                  builder: (context) => AddEditContactDialog(
                    name: newState.name,
                    phoneNumber: newState.phoneNumber,
                    group: "customers",
                  ),
                );
                if (contactData != null) {
                  bloc.add(OrderManagmentEventOnAddNewContact(
                    name: contactData.$1,
                    phoneNumber: contactData.$2,
                    group: contactData.$3,
                  ));
                }
              case const (OrderManagmentOpenSortDialog):
                final newState = state as OrderManagmentOpenSortDialog;
                final sortCategory = await showDialog(
                  context: context,
                  builder: (context) => SortOrdersDialog(
                      checkboxesOldValues: newState.filterOrders),
                );
                if (sortCategory != null && sortCategory != false)
                  bloc.add(OrderManagmentEventOnSorted(sortCategory));

              case const (OrderManagmentOnDeleteDialog):
                final newState = state as OrderManagmentOnDeleteDialog;
                final userChoice = await showDialog(
                  context: context,
                  builder: (context) => GeneralDialog(
                      title: "${appTranslate("sure_delete_order", arguments: {
                        "num": newState.order.orderId
                      })}\n${appTranslate("action_irreversible")}"),
                );
                if (userChoice == true) {
                  bloc.add(OrderManagmentEventDeleteOrder(newState.order));
                }
            }
          },
          builder: (context, state) {
            final bloc = context.read<OrderManagmentInnerBloc>();
            log(name: "state", state.runtimeType.toString());
            return Scaffold(
              appBar: appAppBar(title: appTranslate('orders_managment')),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () => bloc.add(OrderManagmentEventOnSortClicked()),
                label: Text(appTranslate("filter")),
                icon: Icon(Icons.sort),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: state.allOrders.isEmpty
                  ? Center(
                      child: Text(appTranslate("not_order_found"),
                          style: AppTextStyle().title),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 12, left: 12, right: 12, bottom: 80),
                      child: SizedBox(
                        height: screenHeight,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.allOrders.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final order = state.allOrders[index];

                            return OrderManagmentCard(
                              order: order,
                              onDelete: (context) => bloc.add(
                                  OrderManagmentEventDeleteOrderDialog(order)),
                              onChangeStatus: (context) => bloc.add(
                                  OrderManagmentEventChangeOrderStatusOpenDialog(
                                      order)),
                              onPrint: () => bloc.add(
                                  OrderManagmentEventOpenPrintDialog(order)),
                              onAddContact: () => bloc.add(
                                  OrderManagmentEventOpenAddContactDialog(
                                      name: order.customerName,
                                      phoneNumber: order.phoneNumber)),
                            );
                          },
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
