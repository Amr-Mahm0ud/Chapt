// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginObject {
  String get email => throw _privateConstructorUsedError;
  String get pass => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String email, String pass});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? pass = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      pass: null == pass
          ? _value.pass
          : pass // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppServicesClientImplCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$AppServicesClientImplCopyWith(_$AppServicesClientImpl value,
          $Res Function(_$AppServicesClientImpl) then) =
      __$$AppServicesClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String pass});
}

/// @nodoc
class __$$AppServicesClientImplCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$AppServicesClientImpl>
    implements _$$AppServicesClientImplCopyWith<$Res> {
  __$$AppServicesClientImplCopyWithImpl(_$AppServicesClientImpl _value,
      $Res Function(_$AppServicesClientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? pass = null,
  }) {
    return _then(_$AppServicesClientImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == pass
          ? _value.pass
          : pass // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AppServicesClientImpl implements _AppServicesClient {
  _$AppServicesClientImpl(this.email, this.pass);

  @override
  final String email;
  @override
  final String pass;

  @override
  String toString() {
    return 'LoginObject(email: $email, pass: $pass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppServicesClientImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.pass, pass) || other.pass == pass));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, pass);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppServicesClientImplCopyWith<_$AppServicesClientImpl> get copyWith =>
      __$$AppServicesClientImplCopyWithImpl<_$AppServicesClientImpl>(
          this, _$identity);
}

abstract class _AppServicesClient implements LoginObject {
  factory _AppServicesClient(final String email, final String pass) =
      _$AppServicesClientImpl;

  @override
  String get email;
  @override
  String get pass;
  @override
  @JsonKey(ignore: true)
  _$$AppServicesClientImplCopyWith<_$AppServicesClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
