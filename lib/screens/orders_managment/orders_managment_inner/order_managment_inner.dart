import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/repos/orders_repo.dart';
import 'package:tzamtzam_hadar/screens/orders_managment/orders_managment_inner/bloc/order_managment_inner_bloc.dart';
import 'package:tzamtzam_hadar/widgets/cards/order_managment_card.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/change_order_status_dialog.dart';
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
      ],
      child: BlocProvider(
        create: (context) => OrderManagmentInnerBloc(
          context.read<OrdersRepo>(),
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
            }
          },
          builder: (context, state) {
            final bloc = context.read<OrderManagmentInnerBloc>();
            return Scaffold(
              appBar: appAppBar(title: appTranslate('orders_managment')),
              body: state.allOrders.isEmpty
                  ? Center(
                      child: Text(appTranslate("not_order_found"),
                          style: AppTextStyle().title),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          height: screenHeight,
                          child: ListView.separated(
                            itemCount: state.allOrders.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final order = state.allOrders[index];

                              return OrderManagmentCard(
                                order: order,
                                onDelete: (context) => bloc
                                    .add(OrderManagmentEventDeleteOrder(order)),
                                onChangeStatus: (context) => bloc.add(
                                    OrderManagmentEventChangeOrderStatusOpenDialog(
                                        order)),
                              );
                            },
                          ),

                          // child: ListView.separated(
                          //   itemCount: state.orders.length,
                          //   separatorBuilder: (context, index) =>
                          //       SizedBox(height: 8),
                          //   itemBuilder: (context, index) {
                          //     final orderList = state.orders[index];
                          //     final order = state.orders[index];

                          //     return OrderManagmentCard(
                          //       order: newOrder!.values.first,
                          //       onDelete: (context) => bloc.add(
                          //           OrderManagmentEventDeleteOrder(
                          //               newOrder.values.first)),
                          //       onChangeStatus: (context) => bloc.add(
                          //           OrderManagmentEventChangeOrderStatusOpenDialog(
                          //               newOrder.values.first)),
                          //     );
                          //   },
                          // ),
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
