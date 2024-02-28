// ignore_for_file: public_member_api_docs, sort_constructors_first
// @HiveType(typeId: 100)
// extends HiveObject

class Order {
  // static const String boxKey = '0404_news_card';

  // @HiveField(0)
  final String orderId;
  final String date;
  final String time;
  final String fullName;
  final String phoneNumber;

  Order({
    required this.orderId,
    required this.date,
    required this.time,
    required this.fullName,
    required this.phoneNumber,
  });

  @override
  String toString() {
    return 'Order(orderId: $orderId, date: $date, time: $time, fullName: $fullName, phoneNumber: $phoneNumber)';
  }
}
