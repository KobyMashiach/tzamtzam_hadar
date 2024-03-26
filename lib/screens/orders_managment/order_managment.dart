import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/screens/orders_managment/bloc/order_managment_bloc.dart';
import 'package:tzamtzam_hadar/widgets/cards/order_managment_card.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

class OrderManagment extends StatelessWidget {
  const OrderManagment({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) =>
          OrderManagmentBloc()..add(OrderManagmentEventInitial()),
      child: BlocConsumer<OrderManagmentBloc, OrderManagmentState>(
        listenWhen: (previous, current) =>
            current is OrderManagmentNavigatorState,
        buildWhen: (previous, current) =>
            current is! OrderManagmentNavigatorState,
        listener: (context, state) {
          switch (state.runtimeType) {}
        },
        builder: (context, state) {
          final bloc = context.read<OrderManagmentBloc>();
          return Scaffold(
            appBar: appAppBar(title: appTranslate(context, 'orders_managment')),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => KheasydevDialog(
                    title: appTranslate(context, "are_you_sure"),
                    primaryColor: AppColor.primaryColor,
                    buttons: [
                      GenericButtonModel(
                          text: appTranslate(context, "yes"),
                          type: GenericButtonType.outlined,
                          onPressed: () async {
                            await OrdersDataSource.clearOrders();
                            bloc.add(OrderManagmentEventInitial());
                            Navigator.of(context).pop();
                          }),
                      GenericButtonModel(
                          text: appTranslate(context, "no"),
                          type: GenericButtonType.outlined,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                );
              },
              label: Text(appTranslate(context, "delete_all_orders")),
              icon: Icon(Icons.delete_outline),
            ),
            body: state.orders.isEmpty
                ? Center(
                    child: Text(appTranslate(context, "not_order_found"),
                        style: AppTextStyle().title),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height: screenHeight,
                        child: ListView.separated(
                          itemCount: state.orders.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final order = state.orders[index];
                            return OrderManagmentCard(order: order);
                          },
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
