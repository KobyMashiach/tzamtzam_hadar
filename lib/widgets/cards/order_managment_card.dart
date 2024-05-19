import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kh_easy_dev/widgets/navigate_page.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/general_data_source.dart';
import 'package:tzamtzam_hadar/models/order_model/orders_model.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';
import 'package:tzamtzam_hadar/services/general_subwidgets.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/general_dialog.dart';

class OrderManagmentCard extends StatefulWidget {
  const OrderManagmentCard(
      {super.key,
      required this.order,
      this.onDelete,
      this.onChangeStatus,
      this.onPrint,
      this.onAddContact});
  final OrderModel order;
  final Function(BuildContext context)? onDelete;
  final Function(BuildContext context)? onChangeStatus;
  final VoidCallback? onPrint;
  final VoidCallback? onAddContact;

  @override
  State<OrderManagmentCard> createState() => _OrderManagmentCardState();
}

class _OrderManagmentCardState extends State<OrderManagmentCard> {
  bool cardExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: GeneralDataSource.getPermissions().toId() <= 3,
      key: ValueKey(1),
      startActionPane: GeneralSubwidgets()
          .slidableGeneralActionPane(onDelete: widget.onDelete, moreButtons: [
        // SlidableAction(
        //   onPressed: widget.onPrint,
        //   backgroundColor: Colors.grey,
        //   foregroundColor: Colors.white,
        //   icon: Icons.details,
        //   label: appTranslate('print'),
        // ),
        SlidableAction(
          onPressed: (context) async {
            await showDialog(
                context: context,
                builder: (context) {
                  return GeneralDialog(
                    title: appTranslate('what_want_todo'),
                    child: more_actions_menu(),
                    noOkCancelButtons: true,
                  );
                });
          },
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white,
          icon: Icons.menu,
          label: appTranslate('actions'),
        ),
      ]),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: widget.onChangeStatus,
            backgroundColor: getBackgroundColor(widget.order.status),
            foregroundColor: Colors.white,
            icon: Icons.details,
            label:
                "${appTranslate('status')}: ${appTranslate(widget.order.status)}",
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => setState(() {
          cardExpanded = !cardExpanded;
        }),
        child: Card(
          elevation: 8.0,
          child: Container(
            decoration: const BoxDecoration(color: AppColor.primaryColor),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
              child: Column(
                children: [
                  //! first
                  AnimatedCrossFade(
                    firstChild: buildCardHeader(),
                    secondChild: buildExpandedCard(widget.order),
                    crossFadeState: !cardExpanded
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 300),
                  ),
                  //! second
                  // AnimatedContainer(
                  //   duration: const Duration(milliseconds: 300),
                  //   // height: !cardExpanded ? 80 : 260,
                  //   child: Column(
                  //     children: [
                  //       buildCardHeader(),
                  //       SizedBox(height: 12),
                  //       if (cardExpanded) buildExpandedCard(widget.order),
                  //       Icon(
                  //           cardExpanded
                  //               ? Icons.keyboard_arrow_up_rounded
                  //               : Icons.keyboard_arrow_down_rounded,
                  //           color: Colors.black,
                  //           size: 30.0),
                  //     ],
                  //   ),
                  // ),
                  //!third
                  //TODO: checl animatedSwitcher animation
                  // AnimatedSwitcher(
                  //   duration: const Duration(milliseconds: 100),
                  //   // height: !cardExpanded ? 80 : 260,
                  //   transitionBuilder: (child, animation) => SizeTransition(
                  //     sizeFactor: animation,
                  //     child: child,
                  //   ),
                  //   child: !cardExpanded
                  //       ? buildCardHeader()
                  //       : buildExpandedCard(widget.order),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row more_actions_menu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
            if (widget.onPrint != null) {
              widget.onPrint!();
            }
          },
          label: Text(appTranslate("print")),
          icon: Icon(Icons.print),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
            if (widget.onAddContact != null) {
              widget.onAddContact!();
            }
          },
          label: Text(appTranslate("add_contact")),
          icon: Icon(Icons.person_add_alt),
        ),
      ],
    );
  }

  Widget buildExpandedCard(OrderModel order) {
    final categories = globalProductsCategoriesTranslated;
    return Column(
      children: [
        buildCardHeader(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${appTranslate("date")}: ${order.date}"),
            Text("${appTranslate("amount")}: ${order.amount}"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${appTranslate("time")}: ${order.time}"),
            Text("${appTranslate("phone_number")}: ${order.phoneNumber}"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${appTranslate("employee_name")}: ${order.employeeName}"),
            if (order.category == categories[0])
              Text("${appTranslate("canvas_size")}: ${order.canvasSize}"),
            if (order.category == categories[1])
              Column(
                children: [
                  Text("${appTranslate("size")}: ${order.photoSize}"),
                  Text("${appTranslate("fill")}: ${order.photoType}"),
                  Text("${appTranslate("type")}: ${order.photoFill}"),
                ],
              ),
            if (order.category == categories[2])
              Text("${appTranslate("product")}: ${order.sublimationProduct}"),
          ],
        ),
        if (order.notes != null) SizedBox(height: 16),
        if (order.notes != null)
          Text("${appTranslate("notes")}: ${order.notes}"),
        Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black, size: 30.0),
      ],
    );
  }

  Widget buildCardHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.order.orderId, style: AppTextStyle().cardTitle),
            Text(widget.order.customerName, style: AppTextStyle().cardTitle),
            Text(widget.order.category, style: AppTextStyle().cardTitle),
          ],
        ),
        if (!cardExpanded)
          Icon(Icons.keyboard_arrow_down_rounded,
              color: Colors.black, size: 30.0),
      ],
    );
  }

  Color getBackgroundColor(String status) {
    return switch (status) {
      "progress" => Colors.red,
      "hold" => Colors.amber,
      "done" => Colors.green,
      _ => Colors.white
    };
  }
}
