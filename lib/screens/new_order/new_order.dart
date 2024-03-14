import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';
import 'package:tzamtzam_hadar/screens/new_order/bloc/new_order_bloc.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';
import 'package:tzamtzam_hadar/widgets/app_dropdown.dart';
import 'package:tzamtzam_hadar/widgets/app_loading_page.dart';
import 'package:tzamtzam_hadar/widgets/app_radio_list_tile.dart';
import 'package:tzamtzam_hadar/widgets/design/app_textfields.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  late TextEditingController _customerName;
  late TextEditingController _customerPhoneNumber;
  late TextEditingController _employeeName;
  late TextEditingController _notes;
  int _amount = 0;

  // categories
  late List<String> categories;
  String? category;

  // canvases
  late List<String> canvasSizes;
  String? canvasSize;
  bool canvasSizeExpanded = false;

  // sublimation
  late List<String> sublimationProducts;
  String? sublimationProduct;
  bool sublimationProductExpanded = false;

  // pictures
  late List<String> picturesSizes;
  late List<String> picturesTypes;
  late List<String> picturesFill;
  String? pictureSize;
  String? pictureType;
  String? pictureFill;
  bool pictureSizesExpanded = false;
  bool pictureTypesExpanded = false;
  bool pictureFillExpanded = false;

  @override
  void initState() {
    _customerName = TextEditingController();
    _customerPhoneNumber = TextEditingController();
    _employeeName = TextEditingController();
    _notes = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _customerName.dispose();
    _customerPhoneNumber.dispose();
    _employeeName.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardDisable = MediaQuery.of(context).viewInsets.bottom;
    return RepositoryProvider(
      create: (context) => OrdersDataSource(),
      child: BlocProvider(
        create: (context) => NewOrderBloc(context.read<OrdersDataSource>())
          ..add(NewOrderEventInitial(context)),
        child: BlocConsumer<NewOrderBloc, NewOrderState>(
          listenWhen: (previous, current) => current is NewOrderNavigationState,
          buildWhen: (previous, current) => current is! NewOrderNavigationState,
          listener: (context, state) {},
          builder: (context, state) {
            final bloc = context.read<NewOrderBloc>();

            if (state is NewOrderOnLoading) {
              return AppLoading();
            }

            categories = state.categories;
            picturesSizes = state.picturesSizes;
            picturesTypes = state.picturesTypes;
            picturesFill = state.picturesFill;
            canvasSizes = state.canvasSizes;
            sublimationProducts = state.sublimationProducts;
            return Scaffold(
                appBar: appAppBar(title: appTranslate(context, "new_order")),
                floatingActionButton: keyboardDisable == 0
                    ? FloatingActionButton.extended(
                        onPressed: () {
                          doneOrderMenu(context, bloc, state, screenHeight);
                        },
                        label: Text(appTranslate(context, "finish_order")),
                        icon: Icon(Icons.done),
                      )
                    : SizedBox.shrink(),
                body: Padding(
                  padding: const EdgeInsets.only(top: 24, right: 24, left: 24),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: _getScreenHeight(screenHeight),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              appTranslate(context, 'order_number',
                                  arguments: {"num": state.orderId}),
                              style: AppTextStyle().title,
                            ),
                          ),
                          heightSpace(),
                          dateAndTime(context, state),
                          heightSpace(),
                          nameAndPhoneFields(context),
                          categoriesDropdown(context),
                          heightSpace(),
                          getCategoryField(context),
                          heightSpace(),
                          amountOfProduct(context),
                          AppTextField(
                            hintText: appTranslate(context, 'employee_name'),
                            controller: _employeeName,
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          Expanded(
                            child: AppTextField(
                              hintText: appTranslate(context, 'notes'),
                              controller: _notes,
                              maxLines: 5,
                              textInputAction: TextInputAction.newline,
                              keyboard: TextInputType.multiline,
                              padding: EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }

  SizedBox heightSpace() => SizedBox(height: 12);

  double _getScreenHeight(double screenHeight) {
    return (pictureSizesExpanded ||
            pictureFillExpanded ||
            pictureTypesExpanded ||
            canvasSizeExpanded)
        ? screenHeight * 1.3
        : screenHeight;
  }

  Future<void> doneOrderMenu(BuildContext context, NewOrderBloc bloc,
      NewOrderState state, double screenHeight) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: screenHeight * 0.3,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 24),
                Expanded(
                  child: Text(appTranslate(context, "what_want_todo"),
                      style: AppTextStyle().title),
                ),
                kheasydevDivider(black: true),
                Expanded(
                  child: ListTile(
                    onTap: () async {
                      await OrdersDataSource.clearOrders();
                      log(name: "order done", "finish order");
                    },
                    title: Text(appTranslate(context, "finish_order")),
                    leading: Icon(Icons.download_done_rounded),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    onTap: () {
                      if (!orderValidation(context)) return;
                      bloc.add(NewOrderEventAddOrder(
                          customerName: _customerName.text,
                          phoneNumber: _customerPhoneNumber.text,
                          category: category!,
                          amount: _amount,
                          employeeName: _employeeName.text,
                          canvasSize: canvasSize,
                          photoSize: pictureSize,
                          photoType: pictureType,
                          photoFill: pictureFill,
                          notes: _notes.text,
                          sublimationProduct: sublimationProduct));
                      log(name: "order done", "new order to new customeer");
                    },
                    title: Text(
                        "${appTranslate(context, "new_order")} ${appTranslate(context, "to")}${appTranslate(context, "new_customer")}"),
                    leading: Icon(Icons.person_add_outlined),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    onTap: () {
                      // orderValidation(context);
                      log(name: "order done", "new order to current customer");
                      log(OrdersDataSource.getOrders().toString());
                    },
                    title: Text(
                        "${appTranslate(context, "new_order")} ${appTranslate(context, "to")}${appTranslate(context, "current_customer")}"),
                    leading: Icon(Icons.settings_backup_restore_rounded),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  AppDropDown categoriesDropdown(BuildContext context) {
    return AppDropDown(
        onChanged: (value) {
          log(name: "category type", value);
          setState(() {
            category = value;
          });
        },
        hintText: appTranslate(context, "categories"),
        listValues: categories);
  }

  Row nameAndPhoneFields(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            hintText: appTranslate(context, 'full_name'),
            controller: _customerName,
            textInputAction: TextInputAction.next,
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: AppTextField(
            hintText: appTranslate(context, 'phone_number'),
            controller: _customerPhoneNumber,
            keyboard: TextInputType.phone,
            // textInputAction: TextInputAction.next,
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ],
    );
  }

  Row dateAndTime(BuildContext context, NewOrderState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("${appTranslate(context, 'date')}: ${state.date}"),
        Text("${appTranslate(context, 'time')}: ${state.time}"),
      ],
    );
  }

  Widget getCategoryField(BuildContext context) {
    if (categories.isNotEmpty) {
      if (category == categories[0])
        return Column(
          children: subCategories(context, title: 'canvas_size'),
        );
      else if (category == categories[1]) {
        return Column(
          children: [
            ...subCategories(context, title: 'size'),
            ...subCategories(context, title: 'type'),
            ...subCategories(context, title: 'fill'),
          ],
        );
      } else if (category == categories[2]) {
        return Column(
          children: subCategories(context, title: 'product'),
        );
      } else if (category == categories[3]) {
        return Text(appTranslate(context, "write_in_notes"));
      }
    }
    return SizedBox.shrink();
  }

  Row amountOfProduct(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appTranslate(context, 'amount'),
          style: AppTextStyle().mainListValues,
        ),
        SizedBox(width: 24),
        Expanded(
            child: AppTextField(
          hintText: '0',
          hintTextCenter: true,
          onChanged: (value) {
            setState(() {
              _amount = int.tryParse(value) ?? 0;
            });
          },
          padding: EdgeInsets.all(0),
        )),
        Expanded(
          flex: 3,
          child: SizedBox.shrink(),
        ),
      ],
    );
  }

  List<Widget> subCategories(BuildContext context, {required String title}) {
    return [
      heightSpace(),
      GestureDetector(
        onTap: () => setState(() {
          changeExpanded(title);
        }),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appTranslate(context, title),
              style: AppTextStyle().title.copyWith(fontSize: 20),
            ),
            Icon(
              getExpandedBool(title)
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
            ),
          ],
        ),
      ),
      AnimatedCrossFade(
        duration: Duration(milliseconds: 300),
        crossFadeState: getExpandedBool(title)
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: Column(
          children: [
            kheasydevDivider(black: true),
            AppRadioListTile(
              onChanged: (value) {
                log(name: "choose", "$title:$value");
                setState(() {
                  saveValue(value, title);
                });
              },
              listValues: getExpandedList(title),
              crossAxisCount: getExpandedList(title).length < 3 ? 2 : null,
            ),
          ],
        ),
        secondChild: SizedBox.shrink(),
      ),
    ];
  }

  void saveValue(String value, String title) {
    closeAllExpanded(value);
    switch (getValueIndex(title)) {
      case 0:
        pictureSize = value;
      case 1:
        pictureType = value;
      case 2:
        pictureFill = value;
      case 3:
        canvasSize = value;
      default:
        sublimationProduct = value;
    }
  }

  void changeExpanded(String value) {
    closeAllExpanded(value);
    switch (getValueIndex(value)) {
      case 0:
        pictureSizesExpanded = !pictureSizesExpanded;
      case 1:
        pictureTypesExpanded = !pictureTypesExpanded;
      case 2:
        pictureFillExpanded = !pictureFillExpanded;
      case 3:
        canvasSizeExpanded = !canvasSizeExpanded;
      default:
        sublimationProductExpanded = !sublimationProductExpanded;
    }
  }

  void closeAllExpanded(String value) {
    switch (getValueIndex(value)) {
      case 0:
        pictureFillExpanded = false;
        pictureTypesExpanded = false;
      case 1:
        pictureSizesExpanded = false;
        pictureFillExpanded = false;
      default:
        pictureSizesExpanded = false;
        pictureTypesExpanded = false;
      // default:
      //   canvasSizeExpanded = false;
    }
  }

  bool getExpandedBool(String value) {
    return switch (getValueIndex(value)) {
      0 => pictureSizesExpanded,
      1 => pictureTypesExpanded,
      2 => pictureFillExpanded,
      3 => canvasSizeExpanded,
      _ => sublimationProductExpanded
    };
  }

  List<String> getExpandedList(String value) {
    return switch (getValueIndex(value)) {
      0 => picturesSizes,
      1 => picturesTypes,
      2 => picturesFill,
      3 => canvasSizes,
      _ => sublimationProducts,
    };
  }

  int getValueIndex(String value) {
    return switch (value) {
      "size" => 0,
      "type" => 1,
      "fill" => 2,
      "canvas_size" => 3,
      _ => 4,
    };
  }

  bool orderValidation(BuildContext context) {
    if (_customerName.text.isEmpty ||
        _customerPhoneNumber.text.isEmpty ||
        _employeeName.text.isEmpty) {
      kheasydevAppToast(
          appTranslate(context, "missing_customer_employee_details"));
      return false;
    }
    if (category == categories[0]) {
      if (canvasSize == null || canvasSize!.isEmpty) {
        kheasydevAppToast(appTranslate(context, "missing_canvas_size"));
        return false;
      }
    }
    if (category == categories[1]) {
      if (pictureSize == null ||
          pictureSize!.isEmpty ||
          pictureFill == null ||
          pictureFill!.isEmpty ||
          pictureType == null ||
          pictureType!.isEmpty) {
        kheasydevAppToast(appTranslate(context, "missing_picture_details"));
        return false;
      }
    }
    if (category == categories[2]) {
      if (sublimationProduct == null || sublimationProduct!.isEmpty) {
        kheasydevAppToast(appTranslate(context, "missing_sublimation_size"));
        return false;
      }
    }
    if (_amount <= 0) {
      kheasydevAppToast(appTranslate(context, "missing_amount"));
      return false;
    }

    return true;
  }
}
