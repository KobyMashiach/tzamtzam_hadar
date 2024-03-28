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
