import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';
import 'package:tzamtzam_hadar/screens/orders_managment/bloc/order_managment_bloc.dart';
import 'package:tzamtzam_hadar/widgets/design/cards/order_managment_card.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

class OrderManagment extends StatelessWidget {
  const OrderManagment({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardDisable = MediaQuery.of(context).viewInsets.bottom;
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
          return Scaffold(
              appBar:
                  appAppBar(title: appTranslate(context, 'orders_managment')),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: screenHeight,
                    child: ListView.separated(
                      itemCount: state.orders.length,
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final order = state.orders[index];
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            //ToDo: expanded card
                          },
                          child: Card(
                            elevation: 8.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: AppColor.primaryColor),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: OrderManagmentCard(order: order),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
