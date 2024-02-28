import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/widgets/app_dropdown.dart';
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

  void _clearControllers() {
    _customerPhoneNumber.clear();
    _customerName.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appAppBar(title: widget.title),
        body: Padding(
          padding: const EdgeInsets.only(top: 24, right: 24, left: 24),
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
              Expanded(
                  child: AppDropDown(
                      onChanged: (value) {}, listValues: ["asd", "asd"])),
              Row(
                children: [
                  //TODO: check this
                  // Expanded(
                  //   child: AppDropDown(
                  //     hintText: appTranslate(context, 'full_name'),
                  //     listValues: ["תמונות"],
                  //   ),
                  // ),
                  // SizedBox(width: 12),
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
        ));
  }
}
