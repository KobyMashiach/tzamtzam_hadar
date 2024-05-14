import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/repos/orders_repo.dart';
import 'package:tzamtzam_hadar/screens/orders_managment/new_order_inner/bloc/new_order_inner_bloc.dart';
import 'package:tzamtzam_hadar/widgets/design/fields/app_dropdown.dart';
import 'package:tzamtzam_hadar/widgets/design/fields/app_radio_list_tile.dart';
import 'package:tzamtzam_hadar/widgets/design/fields/app_textfields.dart';
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
  late TextEditingController _amount;
  // int _amount = 0;

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
    _amount = TextEditingController();
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
        create: (context) => NewOrderInnerBloc(
          context.read<OrdersDataSource>(),
          context.read<OrdersRepo>(),
        )..add(NewOrderEventInitial(context)),
        child: BlocConsumer<NewOrderInnerBloc, NewOrderInnerState>(
          listenWhen: (previous, current) => current is NewOrderNavigationState,
          buildWhen: (previous, current) => current is! NewOrderNavigationState,
          listener: (context, state) {
            //TODO: add ask printing dialog
            switch (state.runtimeType) {
              case const (NewOrderNavigationNavToHomeScreen):
                //TODO: change to popuntil
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
            }
          },
          builder: (context, state) {
            final bloc = context.read<NewOrderInnerBloc>();

            if (state is NewOrderOnNewOrderState) {
              clearData(state.newCustomer);
              Navigator.of(context).pop();
              bloc.add(NewOrderEventInitial(context));
            }

            categories = state.categories;
            picturesSizes = state.picturesSizes;
            picturesTypes = state.picturesTypes;
            picturesFill = state.picturesFill;
            canvasSizes = state.canvasSizes;
            sublimationProducts = state.sublimationProducts;
            return Scaffold(
                appBar: appAppBar(title: appTranslate("new_order")),
                floatingActionButton: keyboardDisable == 0
                    ? FloatingActionButton.extended(
                        onPressed: () {
                          doneOrderMenu(context, bloc, state, screenHeight);
                        },
                        label: Text(appTranslate("finish_order")),
                        icon: Icon(Icons.done),
                      )
                    : SizedBox.shrink(),
                body: state is NewOrderOnLoading
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding:
                            const EdgeInsets.only(top: 24, right: 24, left: 24),
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: _getScreenHeight(screenHeight),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    appTranslate('order_number',
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
                                  hintText: appTranslate('employee_name'),
                                  controller: _employeeName,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                ),
                                Expanded(
                                  child: AppTextField(
                                    hintText: appTranslate('notes'),
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

  Future<void> doneOrderMenu(BuildContext context, NewOrderInnerBloc bloc,
      NewOrderInnerState state, double screenHeight) {
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
                  child: Text(appTranslate("what_want_todo"),
                      style: AppTextStyle().title),
                ),
                kheasydevDivider(black: true),
                Expanded(
                  child: ListTile(
                    onTap: () async {
                      if (!orderValidation(context)) return;
                      saveOrder(bloc);
                      log(name: "order done", "finish order");
                      bloc.add(NewOrderEventNavToHomeScreen());
                    },
                    title: Text(appTranslate("finish_order")),
                    leading: Icon(Icons.download_done_rounded),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    onTap: () {
                      if (!orderValidation(context)) return;
                      saveOrder(bloc);
                      log(name: "order done", "new order to new customer");
                      bloc.add(NewOrderOnNewOrder(newCustomer: true));
                    },
                    title: Text(
                        "${appTranslate("new_order")} ${appTranslate("to")}${appTranslate("new_customer")}"),
                    leading: Icon(Icons.person_add_outlined),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    onTap: () {
                      if (!orderValidation(context)) return;
                      saveOrder(bloc);
                      bloc.add(NewOrderOnNewOrder(newCustomer: false));
                    },
                    title: Text(
                        "${appTranslate("new_order")} ${appTranslate("to")}${appTranslate("current_customer")}"),
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
      hintText: appTranslate("categories"),
      listValues: categories,
      value: category != null ? category : null,
    );
  }

  Row nameAndPhoneFields(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            hintText: appTranslate('full_name'),
            controller: _customerName,
            textInputAction: TextInputAction.next,
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: AppTextField(
            hintText: appTranslate('phone_number'),
            controller: _customerPhoneNumber,
            keyboard: TextInputType.phone,
            // textInputAction: TextInputAction.next,
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ],
    );
  }

  Row dateAndTime(BuildContext context, NewOrderInnerState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("${appTranslate('date')}: ${state.date}"),
        Text("${appTranslate('time')}: ${state.time}"),
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
        return Text(appTranslate("write_in_notes"));
      }
    }
    return SizedBox.shrink();
  }

  Row amountOfProduct(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appTranslate('amount'),
          style: AppTextStyle().mainListValues,
        ),
        SizedBox(width: 24),
        Expanded(
            child: AppTextField(
          hintText: '0',
          hintTextCenter: true,
          controller: _amount,
          keyboard: TextInputType.number,
          onChanged: (value) {
            setState(() {
              _amount.text = value;
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
              appTranslate(title),
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
      kheasydevAppToast(appTranslate("missing_customer_employee_details"));
      return false;
    }
    if (category == categories[0]) {
      if (canvasSize == null || canvasSize!.isEmpty) {
        kheasydevAppToast(appTranslate("missing_canvas_size"));
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
        kheasydevAppToast(appTranslate("missing_picture_details"));
        return false;
      }
    }
    if (category == categories[2]) {
      if (sublimationProduct == null || sublimationProduct!.isEmpty) {
        kheasydevAppToast(appTranslate("missing_sublimation_size"));
        return false;
      }
    }
    if (int.parse(_amount.text) <= 0) {
      kheasydevAppToast(appTranslate("missing_amount"));
      return false;
    }

    return true;
  }

  saveOrder(NewOrderInnerBloc bloc) {
    bloc.add(NewOrderEventAddOrder(
        customerName: _customerName.text,
        phoneNumber: _customerPhoneNumber.text,
        category: category!,
        amount: int.parse(_amount.text),
        employeeName: _employeeName.text,
        canvasSize: canvasSize,
        photoSize: pictureSize,
        photoType: pictureType,
        photoFill: pictureFill,
        notes: _notes.text,
        sublimationProduct: sublimationProduct));
  }

  void clearData(bool newCustomer) {
    if (newCustomer) {
      _customerName.clear();
      _customerPhoneNumber.clear();
      _employeeName.clear();
    }
    _notes.clear();
    _amount.clear();
    // category = null;
    canvasSize = null;
    sublimationProduct = null;
    pictureSize = null;
    pictureType = null;
    pictureFill = null;
    canvasSizeExpanded = false;
    sublimationProductExpanded = false;
    pictureSizesExpanded = false;
    pictureTypesExpanded = false;
    pictureFillExpanded = false;
  }
}
