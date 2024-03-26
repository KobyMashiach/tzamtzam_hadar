import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/colors.dart';

class AppRadioListTile extends StatefulWidget {
  final void Function(String) onChanged;
  final List<String> listValues;
  final String? hintText;
  final int? crossAxisCount;

  const AppRadioListTile({
    Key? key,
    required this.onChanged,
    required this.listValues,
    this.hintText,
    this.crossAxisCount,
  }) : super(key: key);

  @override
  State<AppRadioListTile> createState() => _AppRadioListTileState();
}

class _AppRadioListTileState extends State<AppRadioListTile> {
  late String? value;

  @override
  void initState() {
    super.initState();
    value = null;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: widget.crossAxisCount ?? 3,
      children: widget.listValues.map((String pictureSize) {
        return RadioListTile<String>(
            title: Text(pictureSize),
            contentPadding: EdgeInsets.all(0),
            activeColor: AppColor.primaryColor,
            value: pictureSize,
            groupValue: value,
            onChanged: (newValue) {
              value = newValue;
              widget.onChanged(newValue!);
            });
      }).toList(),
    );
  }
}
