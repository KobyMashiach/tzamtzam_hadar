// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_in_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderInModel _$OrderInModelFromJson(Map<String, dynamic> json) {
  return _OrderInModel.fromJson(json);
}

/// @nodoc
mixin _$OrderInModel {
  @HiveField(0)
  String? get photoSize => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get photoType => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get photoFill => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get canvasSize => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get sublimationProduct => throw _privateConstructorUsedError;
  @HiveField(5)
  int get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderInModelCopyWith<OrderInModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderInModelCopyWith<$Res> {
  factory $OrderInModelCopyWith(
          OrderInModel value, $Res Function(OrderInModel) then) =
      _$OrderInModelCopyWithImpl<$Res, OrderInModel>;
  @useResult
  $Res call(
      {@HiveField(0) String? photoSize,
      @HiveField(1) String? photoType,
      @HiveField(2) String? photoFill,
      @HiveField(3) String? canvasSize,
      @HiveField(4) String? sublimationProduct,
      @HiveField(5) int amount});
}

/// @nodoc
class _$OrderInModelCopyWithImpl<$Res, $Val extends OrderInModel>
    implements $OrderInModelCopyWith<$Res> {
  _$OrderInModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photoSize = freezed,
    Object? photoType = freezed,
    Object? photoFill = freezed,
    Object? canvasSize = freezed,
    Object? sublimationProduct = freezed,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
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
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderInModelImplCopyWith<$Res>
    implements $OrderInModelCopyWith<$Res> {
  factory _$$OrderInModelImplCopyWith(
          _$OrderInModelImpl value, $Res Function(_$OrderInModelImpl) then) =
      __$$OrderInModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? photoSize,
      @HiveField(1) String? photoType,
      @HiveField(2) String? photoFill,
      @HiveField(3) String? canvasSize,
      @HiveField(4) String? sublimationProduct,
      @HiveField(5) int amount});
}

/// @nodoc
class __$$OrderInModelImplCopyWithImpl<$Res>
    extends _$OrderInModelCopyWithImpl<$Res, _$OrderInModelImpl>
    implements _$$OrderInModelImplCopyWith<$Res> {
  __$$OrderInModelImplCopyWithImpl(
      _$OrderInModelImpl _value, $Res Function(_$OrderInModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photoSize = freezed,
    Object? photoType = freezed,
    Object? photoFill = freezed,
    Object? canvasSize = freezed,
    Object? sublimationProduct = freezed,
    Object? amount = null,
  }) {
    return _then(_$OrderInModelImpl(
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
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 100, adapterName: 'OrderModelAdapter')
class _$OrderInModelImpl implements _OrderInModel {
  _$OrderInModelImpl(
      {@HiveField(0) this.photoSize,
      @HiveField(1) this.photoType,
      @HiveField(2) this.photoFill,
      @HiveField(3) this.canvasSize,
      @HiveField(4) this.sublimationProduct,
      @HiveField(5) required this.amount});

  factory _$OrderInModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderInModelImplFromJson(json);

  @override
  @HiveField(0)
  final String? photoSize;
  @override
  @HiveField(1)
  final String? photoType;
  @override
  @HiveField(2)
  final String? photoFill;
  @override
  @HiveField(3)
  final String? canvasSize;
  @override
  @HiveField(4)
  final String? sublimationProduct;
  @override
  @HiveField(5)
  final int amount;

  @override
  String toString() {
    return 'OrderInModel(photoSize: $photoSize, photoType: $photoType, photoFill: $photoFill, canvasSize: $canvasSize, sublimationProduct: $sublimationProduct, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderInModelImpl &&
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
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, photoSize, photoType, photoFill,
      canvasSize, sublimationProduct, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderInModelImplCopyWith<_$OrderInModelImpl> get copyWith =>
      __$$OrderInModelImplCopyWithImpl<_$OrderInModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderInModelImplToJson(
      this,
    );
  }
}

abstract class _OrderInModel implements OrderInModel {
  factory _OrderInModel(
      {@HiveField(0) final String? photoSize,
      @HiveField(1) final String? photoType,
      @HiveField(2) final String? photoFill,
      @HiveField(3) final String? canvasSize,
      @HiveField(4) final String? sublimationProduct,
      @HiveField(5) required final int amount}) = _$OrderInModelImpl;

  factory _OrderInModel.fromJson(Map<String, dynamic> json) =
      _$OrderInModelImpl.fromJson;

  @override
  @HiveField(0)
  String? get photoSize;
  @override
  @HiveField(1)
  String? get photoType;
  @override
  @HiveField(2)
  String? get photoFill;
  @override
  @HiveField(3)
  String? get canvasSize;
  @override
  @HiveField(4)
  String? get sublimationProduct;
  @override
  @HiveField(5)
  int get amount;
  @override
  @JsonKey(ignore: true)
  _$$OrderInModelImplCopyWith<_$OrderInModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
