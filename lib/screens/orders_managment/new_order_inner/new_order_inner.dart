import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/models/order_in_model/order_in_model.dart';
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

  List<bool> itemsExpandedList = [true];

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
          listener: (context, state) async {
            switch (state.runtimeType) {
              case const (NewOrderNavigationNavToHomeScreen):
                //TODO: change to popuntil
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);

              case const (NewOrderNavigationDeleteItemDialog):
                final newState = state as NewOrderNavigationDeleteItemDialog;
                await showDialog(
                  context: context,
                  builder: (context) => delete_item_dialog(context, newState),
                );
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
                              orderNumberTitle(state),
                              heightSpace(),
                              dateAndTime(context, state),
                              heightSpace(),
                              nameAndPhoneFields(context),
                              itemExpanded(context, bloc),
                              addItemButtom(),
                              employeeNameTextField(),
                              notesTextField(),
                            ],
                          ),
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  Center orderNumberTitle(NewOrderInnerState state) {
    return Center(
      child: Text(
        appTranslate('order_number', arguments: {"num": state.orderId}),
        style: AppTextStyle().title,
      ),
    );
  }

  AppTextField employeeNameTextField() {
    return AppTextField(
      hintText: appTranslate('employee_name'),
      controller: _employeeName,
      padding: EdgeInsets.symmetric(vertical: 8),
    );
  }

  Expanded notesTextField() {
    return Expanded(
      child: AppTextField(
        hintText: appTranslate('notes'),
        controller: _notes,
        maxLines: 5,
        textInputAction: TextInputAction.newline,
        keyboard: TextInputType.multiline,
        padding: EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }

  Container addItemButtom() {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            AppColor.primaryColor,
          ),
        ),
        onPressed: () {
          itemsExpandedList = itemsExpandedList.map((_) => false).toList();
          itemsExpandedList.add(true);
          setState(() {});
        },
        icon: Icon(Icons.add_circle_outline_rounded),
        label: Text(appTranslate("add_item")),
      ),
    );
  }

  KheasydevDialog delete_item_dialog(
      BuildContext context, NewOrderNavigationDeleteItemDialog state) {
    return KheasydevDialog(
      title: appTranslate("are_you_sure"),
      description: appTranslate("delete_item_description"),
      primaryColor: Colors.white,
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
              itemsExpandedList = itemsExpandedList.map((_) => false).toList();
              setState(() {
                itemsExpandedList.removeAt(state.index);
              });
              setState(() {});
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  SizedBox heightSpace() => SizedBox(height: 12);

  double _getScreenHeight(double screenHeight) {
    double newScreenHeight = screenHeight;
    if (pictureSizesExpanded ||
        pictureFillExpanded ||
        pictureTypesExpanded ||
        canvasSizeExpanded) {
      newScreenHeight = screenHeight * 1.3;
    }
    if (itemsExpandedList.contains(true)) {
      newScreenHeight = newScreenHeight * 1.2;
    }
    return newScreenHeight;
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
    pictureFillExpanded = false;
    pictureTypesExpanded = false;
    pictureSizesExpanded = false;

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

  Widget itemExpanded(
    BuildContext context,
    NewOrderInnerBloc bloc,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: itemsExpandedList.length,
      itemBuilder: (context, index) {
        final bool itemExpanded = itemsExpandedList[index];
        return Column(
          children: [
            itemElevatedButton(index, itemExpanded),
            AnimatedCrossFade(
              duration: Duration(milliseconds: 300),
              crossFadeState: itemExpanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: itemExpandedContainer(context, bloc, index),
              secondChild: SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }

  Container itemExpandedContainer(
      BuildContext context, NewOrderInnerBloc bloc, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.shadowColor),
        borderRadius: BorderRadius.circular(34),
      ),
      child: Column(
        children: [
          categoriesDropdown(context),
          heightSpace(),
          getCategoryField(context),
          heightSpace(),
          amountOfProduct(context),
          inItemButton(
            bloc,
            index,
            title: appTranslate("save_item"),
            color: Color(0xFF21B7CA),
            icon: Icons.save_outlined,
            onPressed: () {
              //TODO: orderInModel from here
              // OrderInModel(amount: amount,canvasSize: ,photoFill: ,photoSize: ,photoType: ,sublimationProduct: );
            },
          ),
          inItemButton(
            bloc,
            index,
            title: appTranslate("delete_item"),
            color: Colors.red,
            icon: Icons.remove_circle_outline_rounded,
            onPressed: () => bloc.add(NewOrderOnDeleteItem(index: index)),
          ),
        ],
      ),
    );
  }

  ElevatedButton itemElevatedButton(int index, bool itemExpanded) {
    return ElevatedButton.icon(
      onPressed: () {
        if (itemsExpandedList[index] == true) {
          itemsExpandedList[index] = false;
        } else {
          itemsExpandedList = itemsExpandedList.map((_) => false).toList();

          itemsExpandedList[index] = true;
        }
        setState(() {});
      },
      icon: Icon(itemExpanded ? Icons.arrow_upward : Icons.arrow_downward),
      label: Text("${appTranslate("product")} ${index + 1}"),
    );
  }

  Padding inItemButton(NewOrderInnerBloc bloc, int index,
      {required String title,
      required Color color,
      required IconData icon,
      required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(color),
          ),
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          label: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
