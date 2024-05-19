// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return _OrderModel.fromJson(json);
}

/// @nodoc
mixin _$OrderModel {
  @HiveField(0)
  String get orderId => throw _privateConstructorUsedError;
  @HiveField(1)
  String get date => throw _privateConstructorUsedError;
  @HiveField(2)
  String get time => throw _privateConstructorUsedError;
  @HiveField(3)
  String get customerName => throw _privateConstructorUsedError;
  @HiveField(4)
  String get phoneNumber => throw _privateConstructorUsedError;
  @HiveField(5)
  String get category => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get notes => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get photoSize => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get photoType => throw _privateConstructorUsedError;
  @HiveField(9)
  String? get photoFill => throw _privateConstructorUsedError;
  @HiveField(10)
  String? get canvasSize => throw _privateConstructorUsedError;
  @HiveField(11)
  String? get sublimationProduct => throw _privateConstructorUsedError;
  @HiveField(12)
  String get employeeName => throw _privateConstructorUsedError;
  @HiveField(13)
  int get amount => throw _privateConstructorUsedError;
  @HiveField(14)
  String get status => throw _privateConstructorUsedError;
  @HiveField(15)
  List<OrderInModel> get orderInList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderModelCopyWith<OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderModelCopyWith<$Res> {
  factory $OrderModelCopyWith(
          OrderModel value, $Res Function(OrderModel) then) =
      _$OrderModelCopyWithImpl<$Res, OrderModel>;
  @useResult
  $Res call(
      {@HiveField(0) String orderId,
      @HiveField(1) String date,
      @HiveField(2) String time,
      @HiveField(3) String customerName,
      @HiveField(4) String phoneNumber,
      @HiveField(5) String category,
      @HiveField(6) String? notes,
      @HiveField(7) String? photoSize,
      @HiveField(8) String? photoType,
      @HiveField(9) String? photoFill,
      @HiveField(10) String? canvasSize,
      @HiveField(11) String? sublimationProduct,
      @HiveField(12) String employeeName,
      @HiveField(13) int amount,
      @HiveField(14) String status,
      @HiveField(15) List<OrderInModel> orderInList});
}

/// @nodoc
class _$OrderModelCopyWithImpl<$Res, $Val extends OrderModel>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? date = null,
    Object? time = null,
    Object? customerName = null,
    Object? phoneNumber = null,
    Object? category = null,
    Object? notes = freezed,
    Object? photoSize = freezed,
    Object? photoType = freezed,
    Object? photoFill = freezed,
    Object? canvasSize = freezed,
    Object? sublimationProduct = freezed,
    Object? employeeName = null,
    Object? amount = null,
    Object? status = null,
    Object? orderInList = null,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoSize: freezed == photoSize
          ? _value.photoSize
          : photoSize // ignore: cast_nullable_to_non_nullable
              as String?,
      photoType: freezed == photoType
          ? _value.photoType
          : photoType // ignore: cast_nullable_to_non_nullable
              as String?,
      photoFill: freezed == photoFill
          ? _value.photoFill
          : photoFill // ignore: cast_nullable_to_non_nullable
              as String?,
      canvasSize: freezed == canvasSize
          ? _value.canvasSize
          : canvasSize // ignore: cast_nullable_to_non_nullable
              as String?,
      sublimationProduct: freezed == sublimationProduct
          ? _value.sublimationProduct
          : sublimationProduct // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      orderInList: null == orderInList
          ? _value.orderInList
          : orderInList // ignore: cast_nullable_to_non_nullable
              as List<OrderInModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderModelImplCopyWith<$Res>
    implements $OrderModelCopyWith<$Res> {
  factory _$$OrderModelImplCopyWith(
          _$OrderModelImpl value, $Res Function(_$OrderModelImpl) then) =
      __$$OrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String orderId,
      @HiveField(1) String date,
      @HiveField(2) String time,
      @HiveField(3) String customerName,
      @HiveField(4) String phoneNumber,
      @HiveField(5) String category,
      @HiveField(6) String? notes,
      @HiveField(7) String? photoSize,
      @HiveField(8) String? photoType,
      @HiveField(9) String? photoFill,
      @HiveField(10) String? canvasSize,
      @HiveField(11) String? sublimationProduct,
      @HiveField(12) String employeeName,
      @HiveField(13) int amount,
      @HiveField(14) String status,
      @HiveField(15) List<OrderInModel> orderInList});
}

/// @nodoc
class __$$OrderModelImplCopyWithImpl<$Res>
    extends _$OrderModelCopyWithImpl<$Res, _$OrderModelImpl>
    implements _$$OrderModelImplCopyWith<$Res> {
  __$$OrderModelImplCopyWithImpl(
      _$OrderModelImpl _value, $Res Function(_$OrderModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? date = null,
    Object? time = null,
    Object? customerName = null,
    Object? phoneNumber = null,
    Object? category = null,
    Object? notes = freezed,
    Object? photoSize = freezed,
    Object? photoType = freezed,
    Object? photoFill = freezed,
    Object? canvasSize = freezed,
    Object? sublimationProduct = freezed,
    Object? employeeName = null,
    Object? amount = null,
    Object? status = null,
    Object? orderInList = null,
  }) {
    return _then(_$OrderModelImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoSize: freezed == photoSize
          ? _value.photoSize
          : photoSize // ignore: cast_nullable_to_non_nullable
              as String?,
      photoType: freezed == photoType
          ? _value.photoType
          : photoType // ignore: cast_nullable_to_non_nullable
              as String?,
      photoFill: freezed == photoFill
          ? _value.photoFill
          : photoFill // ignore: cast_nullable_to_non_nullable
              as String?,
      canvasSize: freezed == canvasSize
          ? _value.canvasSize
          : canvasSize // ignore: cast_nullable_to_non_nullable
              as String?,
      sublimationProduct: freezed == sublimationProduct
          ? _value.sublimationProduct
          : sublimationProduct // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      orderInList: null == orderInList
          ? _value._orderInList
          : orderInList // ignore: cast_nullable_to_non_nullable
              as List<OrderInModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 100, adapterName: 'OrderModelAdapter')
class _$OrderModelImpl implements _OrderModel {
  _$OrderModelImpl(
      {@HiveField(0) required this.orderId,
      @HiveField(1) required this.date,
      @HiveField(2) required this.time,
      @HiveField(3) required this.customerName,
      @HiveField(4) required this.phoneNumber,
      @HiveField(5) required this.category,
      @HiveField(6) this.notes,
      @HiveField(7) this.photoSize,
      @HiveField(8) this.photoType,
      @HiveField(9) this.photoFill,
      @HiveField(10) this.canvasSize,
      @HiveField(11) this.sublimationProduct,
      @HiveField(12) required this.employeeName,
      @HiveField(13) required this.amount,
      @HiveField(14) required this.status,
      @HiveField(15) required final List<OrderInModel> orderInList})
      : _orderInList = orderInList;

  factory _$OrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderModelImplFromJson(json);

  @override
  @HiveField(0)
  final String orderId;
  @override
  @HiveField(1)
  final String date;
  @override
  @HiveField(2)
  final String time;
  @override
  @HiveField(3)
  final String customerName;
  @override
  @HiveField(4)
  final String phoneNumber;
  @override
  @HiveField(5)
  final String category;
  @override
  @HiveField(6)
  final String? notes;
  @override
  @HiveField(7)
  final String? photoSize;
  @override
  @HiveField(8)
  final String? photoType;
  @override
  @HiveField(9)
  final String? photoFill;
  @override
  @HiveField(10)
  final String? canvasSize;
  @override
  @HiveField(11)
  final String? sublimationProduct;
  @override
  @HiveField(12)
  final String employeeName;
  @override
  @HiveField(13)
  final int amount;
  @override
  @HiveField(14)
  final String status;
  final List<OrderInModel> _orderInList;
  @override
  @HiveField(15)
  List<OrderInModel> get orderInList {
    if (_orderInList is EqualUnmodifiableListView) return _orderInList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderInList);
  }

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, date: $date, time: $time, customerName: $customerName, phoneNumber: $phoneNumber, category: $category, notes: $notes, photoSize: $photoSize, photoType: $photoType, photoFill: $photoFill, canvasSize: $canvasSize, sublimationProduct: $sublimationProduct, employeeName: $employeeName, amount: $amount, status: $status, orderInList: $orderInList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderModelImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.photoSize, photoSize) ||
                other.photoSize == photoSize) &&
            (identical(other.photoType, photoType) ||
                other.photoType == photoType) &&
            (identical(other.photoFill, photoFill) ||
                other.photoFill == photoFill) &&
            (identical(other.canvasSize, canvasSize) ||
                other.canvasSize == canvasSize) &&
            (identical(other.sublimationProduct, sublimationProduct) ||
                other.sublimationProduct == sublimationProduct) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._orderInList, _orderInList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      orderId,
      date,
      time,
      customerName,
      phoneNumber,
      category,
      notes,
      photoSize,
      photoType,
      photoFill,
      canvasSize,
      sublimationProduct,
      employeeName,
      amount,
      status,
      const DeepCollectionEquality().hash(_orderInList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      __$$OrderModelImplCopyWithImpl<_$OrderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderModelImplToJson(
      this,
    );
  }
}

abstract class _OrderModel implements OrderModel {
  factory _OrderModel(
          {@HiveField(0) required final String orderId,
          @HiveField(1) required final String date,
          @HiveField(2) required final String time,
          @HiveField(3) required final String customerName,
          @HiveField(4) required final String phoneNumber,
          @HiveField(5) required final String category,
          @HiveField(6) final String? notes,
          @HiveField(7) final String? photoSize,
          @HiveField(8) final String? photoType,
          @HiveField(9) final String? photoFill,
          @HiveField(10) final String? canvasSize,
          @HiveField(11) final String? sublimationProduct,
          @HiveField(12) required final String employeeName,
          @HiveField(13) required final int amount,
          @HiveField(14) required final String status,
          @HiveField(15) required final List<OrderInModel> orderInList}) =
      _$OrderModelImpl;

  factory _OrderModel.fromJson(Map<String, dynamic> json) =
      _$OrderModelImpl.fromJson;

  @override
  @HiveField(0)
  String get orderId;
  @override
  @HiveField(1)
  String get date;
  @override
  @HiveField(2)
  String get time;
  @override
  @HiveField(3)
  String get customerName;
  @override
  @HiveField(4)
  String get phoneNumber;
  @override
  @HiveField(5)
  String get category;
  @override
  @HiveField(6)
  String? get notes;
  @override
  @HiveField(7)
  String? get photoSize;
  @override
  @HiveField(8)
  String? get photoType;
  @override
  @HiveField(9)
  String? get photoFill;
  @override
  @HiveField(10)
  String? get canvasSize;
  @override
  @HiveField(11)
  String? get sublimationProduct;
  @override
  @HiveField(12)
  String get employeeName;
  @override
  @HiveField(13)
  int get amount;
  @override
  @HiveField(14)
  String get status;
  @override
  @HiveField(15)
  List<OrderInModel> get orderInList;
  @override
  @JsonKey(ignore: true)
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
