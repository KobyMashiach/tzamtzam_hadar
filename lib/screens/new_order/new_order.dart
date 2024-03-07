import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';
import 'package:tzamtzam_hadar/widgets/app_dropdown.dart';
import 'package:tzamtzam_hadar/widgets/app_radio_list_tile.dart';
import 'package:tzamtzam_hadar/widgets/design/app_textfields.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

class NewOrder extends StatefulWidget {
  final String title;
  final String date;
  final String time;
  const NewOrder(
      {super.key, required this.title, required this.date, required this.time});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  late TextEditingController _customerName;
  late TextEditingController _customerPhoneNumber;

  late List<String> categories;
  late List<String> picturesSizes;
  late List<String> picturesTypes;
  late List<String> picturesFill;

  String? category;
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
    super.initState();
  }

  @override
  void dispose() {
    _customerName.dispose();
    _customerPhoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    categories = categoriesList(context);
    picturesSizes = picturesSizesList(context);
    picturesTypes = picturesTypeList(context);
    picturesFill = picturesFillList(context);
    return Scaffold(
        appBar: appAppBar(title: widget.title),
        body: Padding(
          padding: const EdgeInsets.only(top: 24, right: 24, left: 24),
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      appTranslate(context, 'order_number',
                          arguments: {"num": "34"}),
                      style: AppTextStyle().title,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${appTranslate(context, 'date')}: ${widget.date}"),
                      Text("${appTranslate(context, 'time')}: ${widget.time}"),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
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
                  ),
                  AppDropDown(
                      onChanged: (value) {
                        log(name: "category type", value);
                        setState(() {
                          category = value;
                        });
                      },
                      hintText: appTranslate(context, "categories"),
                      listValues: categories),
                  getCategoryField(context, categories),
                  Expanded(
                    child: AppTextField(
                      hintText: appTranslate(context, 'notes'),
                      // controller: _customerPhoneNumber,
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
  }

  Widget getCategoryField(BuildContext context, List<String> categories) {
    if (category == categories[0])
      return Column(
        children: [
          Row(
            children: [
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
          ),
        ],
      );
    else if (category == categories[1]) {
      return Column(
        children: [
          SizedBox(height: 12),
          ...subCategories(context, title: 'size'),
          ...subCategories(context, title: 'type'),
          ...subCategories(context, title: 'fill'),
          SizedBox(height: 12),
          Row(
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
                padding: EdgeInsets.all(0),
              )),
              Expanded(
                flex: 3,
                child: SizedBox.shrink(),
              ),
            ],
          )
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  List<Widget> subCategories(BuildContext context, {required String title}) {
    return [
      SizedBox(height: 12),
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
                log(name: "pictures $title", value);
                setState(() {
                  saveValue(value);
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

  void saveValue(String value) {
    closeAllExpanded(value);
    switch (getValueIndex(value)) {
      case 0:
        pictureSize = value;
      case 1:
        pictureType = value;
      default:
        pictureFill = value;
    }
  }

  void changeExpanded(String value) {
    closeAllExpanded(value);
    switch (getValueIndex(value)) {
      case 0:
        pictureSizesExpanded = !pictureSizesExpanded;
      case 1:
        pictureTypesExpanded = !pictureTypesExpanded;
      default:
        pictureFillExpanded = !pictureFillExpanded;
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
    }
  }

  bool getExpandedBool(String value) {
    return switch (getValueIndex(value)) {
      0 => pictureSizesExpanded,
      1 => pictureTypesExpanded,
      _ => pictureFillExpanded,
    };
  }

  List<String> getExpandedList(String value) {
    return switch (getValueIndex(value)) {
      0 => picturesSizes,
      1 => picturesTypes,
      _ => picturesFill,
    };
  }

  int getValueIndex(String value) {
    return switch (value) {
      "size" => 0,
      "type" => 1,
      _ => 2,
    };
  }
}
