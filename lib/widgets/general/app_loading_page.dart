import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

Widget AppLoading() => Builder(builder: (context) {
      return Scaffold(
        appBar: appAppBar(
          title: appTranslate("loading_date"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 30),
              Text(
                appTranslate("loading_data"),
                style: AppTextStyle().title,
              )
            ],
          ),
        ),
      );
    });
