import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/conntection.dart';
import 'package:tzamtzam_hadar/core/enums.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/general_data_source.dart';
import 'package:tzamtzam_hadar/hive/lists_maps_data_source.dart';
import 'package:tzamtzam_hadar/models/contact_model.dart';
import 'package:tzamtzam_hadar/repos/lists_maps_repo.dart';
import 'package:tzamtzam_hadar/screens/orders_managment/new_order_inner/new_order_inner.dart';
import 'package:tzamtzam_hadar/screens/orders_managment/orders_managment_inner/order_managment_inner.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

// List<String> globalPicturesSizes = [];
// List<String> globalPicturesSizesTranslated = [];

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final ListsMapsRepo listsMapsRepo;
  SplashScreenBloc({required this.listsMapsRepo})
      : super(SplashScreenInitial()) {
    on<SplashScreenInitialized>(_splashScreenInitialized);
  }

  FutureOr<void> _splashScreenInitialized(
      SplashScreenInitialized event, Emitter<SplashScreenState> emit) async {
    if (await checkConnectionNoInternet()) {
      await Future.delayed(Duration(seconds: 2));
      emit(SplashScreenNavigationToNoInternetScreen());
      return;
    }
    await ListsMapsDataSource.initialise();
    await GeneralDataSource.initialise();
    final allData = await listsMapsRepo.getAllData();

    buildLists(globalPicturesSizes, globalPicturesSizesTranslated,
        ListsEnums.pictures_sizes.getString(), allData);

    buildLists(globalPicturesFill, globalPicturesFillTranslated,
        ListsEnums.pictures_fill.getString(), allData);

    buildLists(globalPicturesType, globalPicturesTypeTranslated,
        ListsEnums.pictures_type.getString(), allData);

    buildLists(globalCanvasSizes, globalCanvasSizesTranslated,
        ListsEnums.canvas_sizes.getString(), allData);

    buildLists(globalManagmentCategories, globalManagmentCategoriesTranslated,
        ListsEnums.managment_categories.getString(), allData);

    buildLists(globalProductsCategories, globalProductsCategoriesTranslated,
        ListsEnums.products_categories.getString(), allData);

    buildLists(globalSublimationProducts, globalSublimationProductsTranslated,
        ListsEnums.sublimation_products.getString(), allData);

    buildLists(globalSendFilesType, globalSendFilesTypeTranslated,
        ListsEnums.send_files_type.getString(), allData);

    buildMaps(globalMainCategories, globalMainCategoriesTranslated,
        MapsEnums.main_categories.getString(), allData);

    buildMaps(globalSendFiles, globalSendFilesTranslated,
        MapsEnums.send_files_map.getString(), allData);

    buildMaps(globalContactsList, globalContactsListTranslated,
        MapsEnums.contactsList.getString(), allData);

    emit(SplashScreenNavigationToSendFilesScreen(allData: allData));
  }

  void buildLists(
      List<String> noTran, List<String> tran, String type, List<dynamic> list) {
    noTran.clear();
    noTran.addAll((list.length == 2
            ? list[0][type] as List<dynamic>
            : list[1][type] as List<dynamic>)
        .map((e) => e.toString())
        .toList());
    tran.clear();
    tran.addAll(noTran.map((str) {
      if (str.isEmpty) return '';
      int? firstChar = int.tryParse(str[0]);
      if (firstChar != null) {
        return str;
      } else {
        return appTranslate(str);
      }
    }).toList());
  }

  void buildMaps(Map<dynamic, dynamic> noTran, Map<dynamic, dynamic> tran,
      String type, List<dynamic> list) {
    noTran.addAll(list.length == 2 ? list[1][type] : list[2][type]);

    if (type == MapsEnums.main_categories.getString()) {
      tran.addAll(Map<String, dynamic>.fromEntries(
        noTran.entries.map((entry) => MapEntry<String, dynamic>(
            appTranslate(entry.key), getMainCategoriesWidget(entry.value))),
      ));
    } else if (type == MapsEnums.send_files_map.getString()) {
      tran.addAll(
        Map<String, dynamic>.fromEntries(
          noTran.entries.map(
              (entry) => MapEntry<String, dynamic>(entry.key, entry.value)),
        ),
      );
    } else if (type == MapsEnums.contactsList.getString()) {
      noTran.forEach(
        (key, value) {
          List<ContactModel> contacts = [];
          value.forEach((map) {
            String name = map['name'] ?? '';
            String phoneNumber = map['phoneNumber'] ?? '';
            contacts.add(ContactModel(name: name, phoneNumber: phoneNumber));
          });
          tran[appTranslate(key)] = contacts;
        },
      );
    }
  }

  // ContactModel(
  //   name: item["name"],
  //   phoneNumber: item["phoneNumber"],
  // ),
  Widget? getMainCategoriesWidget(String value) {
    return switch (value) {
      "NewOrder()" => NewOrder(),
      "OrderManagment()" => OrderManagment(),
      _ => null
    };
  }
}
