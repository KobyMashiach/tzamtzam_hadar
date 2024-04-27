import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:kh_easy_dev/widgets/navigate_page.dart';

AppBar checkAppBar({
  required String title,
  Widget? widgetTitle,
  Widget? leading,
  List<Widget>? actions,
  String? logoPath,
  Color? primaryColor,
  Color? shadowColor,
  Widget? developerPage,
  BuildContext? context,
  Color? titleColor,
  (String, Function(String))? searchAppBar,
}) {
  FocusNode? titleSearchFocus = FocusNode();
  if (searchAppBar != null) titleSearchFocus.requestFocus();
  return AppBar(
    backgroundColor: primaryColor ?? Colors.black,
    title: IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (searchAppBar == null)
            Expanded(
              child: widgetTitle ??
                  Text(
                    title,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: titleColor ?? Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
            ),
          if (searchAppBar != null)
            Expanded(
                child: TextField(
              focusNode: titleSearchFocus,
              decoration: InputDecoration.collapsed(hintText: searchAppBar.$1),
              onChanged: searchAppBar.$2,
            )),
          kheasydevVerticalDivider(),
          GestureDetector(
            onLongPress: () => developerPage != null
                ? KheasydevNavigatePage().push(context!, developerPage)
                : null,
            child: Image.asset(
              logoPath ?? '',
              width: 60,
              height: 60,
            ),
          ),
        ],
      ),
    ),
    leading: leading,
    actions: actions ?? [],
    centerTitle: true,
    toolbarHeight: 70,
    elevation: 20,
    shadowColor: shadowColor ?? Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
