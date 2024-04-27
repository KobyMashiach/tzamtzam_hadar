import 'package:tzamtzam_hadar/core/translates/get_tran.dart';

enum OrderStatus {
  done(1),
  progress(2),
  hold(3);

  const OrderStatus(this.id);

  factory OrderStatus.fromId(int id) {
    return values.firstWhere((e) => e.id == id);
  }
  final int id;

  int toId() {
    return this.id;
  }
}

extension OrderStatusX on OrderStatus {
  String getString() {
    return switch (this) {
      OrderStatus.done => appTranslate('done'),
      OrderStatus.progress => appTranslate('progress'),
      OrderStatus.hold => appTranslate('hold'),
    };
  }

  String getStringToFirestore() {
    return switch (this) {
      OrderStatus.done => 'done',
      OrderStatus.progress => 'progress',
      OrderStatus.hold => 'hold',
    };
  }
}

enum MapsEnums {
  contactsList,
  send_files_map,
  main_categories;

  String getString() {
    return switch (this) {
      MapsEnums.contactsList => 'contactsList',
      MapsEnums.send_files_map => 'send_files_map',
      MapsEnums.main_categories => 'main_categories',
    };
  }
}

enum ListsEnums {
  canvas_sizes,
  managment_categories,
  pictures_fill,
  pictures_sizes,
  pictures_type,
  products_categories,
  send_files_type,
  sublimation_products;

  String getString() {
    return switch (this) {
      ListsEnums.canvas_sizes => 'canvas_sizes',
      ListsEnums.managment_categories => 'managment_categories',
      ListsEnums.pictures_fill => 'pictures_fill',
      ListsEnums.pictures_sizes => 'pictures_sizes',
      ListsEnums.pictures_type => 'pictures_type',
      ListsEnums.products_categories => 'products_categories',
      ListsEnums.send_files_type => 'send_files_type',
      ListsEnums.sublimation_products => 'sublimation_products',
    };
  }
}
