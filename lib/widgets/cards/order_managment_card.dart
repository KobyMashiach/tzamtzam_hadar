import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';

class OrderManagmentCard extends StatefulWidget {
  const OrderManagmentCard({
    super.key,
    required this.order,
  });
  //ToDo: add a slider
  final OrderModel order;

  @override
  State<OrderManagmentCard> createState() => _OrderManagmentCardState();
}

class _OrderManagmentCardState extends State<OrderManagmentCard> {
  bool cardExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        cardExpanded = !cardExpanded;
      }),
      child: Card(
        elevation: 8.0,
        child: Container(
          decoration: const BoxDecoration(color: AppColor.primaryColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  //ToDo: choose minimum height
                  height: !cardExpanded ? 80 : 260,
                  child: Column(
                    children: [
                      buildCardHeader(),
                      SizedBox(height: 12),
                      if (cardExpanded) buildExpandedCard(widget.order),
                      //ToDo: icon in button of card
                      Icon(
                          cardExpanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: Colors.black,
                          size: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildExpandedCard(OrderModel order) {
    final categories = categoriesList(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${appTranslate(context, "date")}: ${order.date}"),
            Text("${appTranslate(context, "amount")}: ${order.amount}"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${appTranslate(context, "time")}: ${order.time}"),
            Text(
                "${appTranslate(context, "phone_number")}: ${order.phoneNumber}"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "${appTranslate(context, "employee_name")}: ${order.employeeName}"),
            if (order.category == categories[0])
              Text(
                  "${appTranslate(context, "canvas_size")}: ${order.canvasSize}"),
            if (order.category == categories[1])
              Column(
                children: [
                  Text("${appTranslate(context, "size")}: ${order.photoSize}"),
                  Text("${appTranslate(context, "fill")}: ${order.photoType}"),
                  Text("${appTranslate(context, "type")}: ${order.photoFill}"),
                ],
              ),
            if (order.category == categories[2])
              Text(
                  "${appTranslate(context, "product")}: ${order.sublimationProduct}"),
          ],
        ),
        if (order.notes != null) SizedBox(height: 16),
        if (order.notes != null)
          Text("${appTranslate(context, "notes")}: ${order.notes}"),
      ],
    );
  }

  Widget buildCardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.order.orderId, style: AppTextStyle().cardTitle),
        Text(widget.order.customerName, style: AppTextStyle().cardTitle),
        Text(widget.order.category, style: AppTextStyle().cardTitle),
      ],
    );
  }
}
