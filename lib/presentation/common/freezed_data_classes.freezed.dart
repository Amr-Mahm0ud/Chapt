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
abstract class _$$LoginObjectImplCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$LoginObjectImplCopyWith(
          _$LoginObjectImpl value, $Res Function(_$LoginObjectImpl) then) =
      __$$LoginObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String pass});
}

/// @nodoc
class __$$LoginObjectImplCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$LoginObjectImpl>
    implements _$$LoginObjectImplCopyWith<$Res> {
  __$$LoginObjectImplCopyWithImpl(
      _$LoginObjectImpl _value, $Res Function(_$LoginObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? pass = null,
  }) {
    return _then(_$LoginObjectImpl(
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

class _$LoginObjectImpl implements _LoginObject {
  _$LoginObjectImpl(this.email, this.pass);

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
            other is _$LoginObjectImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.pass, pass) || other.pass == pass));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, pass);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      __$$LoginObjectImplCopyWithImpl<_$LoginObjectImpl>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(final String email, final String pass) =
      _$LoginObjectImpl;

  @override
  String get email;
  @override
  String get pass;
  @override
  @JsonKey(ignore: true)
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterObject {
  String get email => throw _privateConstructorUsedError;
  String get pass => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get phoneNum => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterObjectCopyWith<RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterObjectCopyWith<$Res> {
  factory $RegisterObjectCopyWith(
          RegisterObject value, $Res Function(RegisterObject) then) =
      _$RegisterObjectCopyWithImpl<$Res, RegisterObject>;
  @useResult
  $Res call({String email, String pass, String userName, String phoneNum});
}

/// @nodoc
class _$RegisterObjectCopyWithImpl<$Res, $Val extends RegisterObject>
    implements $RegisterObjectCopyWith<$Res> {
  _$RegisterObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? pass = null,
    Object? userName = null,
    Object? phoneNum = null,
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
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNum: null == phoneNum
          ? _value.phoneNum
          : phoneNum // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterObjectImplCopyWith<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  factory _$$RegisterObjectImplCopyWith(_$RegisterObjectImpl value,
          $Res Function(_$RegisterObjectImpl) then) =
      __$$RegisterObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String pass, String userName, String phoneNum});
}

/// @nodoc
class __$$RegisterObjectImplCopyWithImpl<$Res>
    extends _$RegisterObjectCopyWithImpl<$Res, _$RegisterObjectImpl>
    implements _$$RegisterObjectImplCopyWith<$Res> {
  __$$RegisterObjectImplCopyWithImpl(
      _$RegisterObjectImpl _value, $Res Function(_$RegisterObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? pass = null,
    Object? userName = null,
    Object? phoneNum = null,
  }) {
    return _then(_$RegisterObjectImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == pass
          ? _value.pass
          : pass // ignore: cast_nullable_to_non_nullable
              as String,
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      null == phoneNum
          ? _value.phoneNum
          : phoneNum // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegisterObjectImpl implements _RegisterObject {
  _$RegisterObjectImpl(this.email, this.pass, this.userName, this.phoneNum);

  @override
  final String email;
  @override
  final String pass;
  @override
  final String userName;
  @override
  final String phoneNum;

  @override
  String toString() {
    return 'RegisterObject(email: $email, pass: $pass, userName: $userName, phoneNum: $phoneNum)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterObjectImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.pass, pass) || other.pass == pass) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.phoneNum, phoneNum) ||
                other.phoneNum == phoneNum));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, pass, userName, phoneNum);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterObjectImplCopyWith<_$RegisterObjectImpl> get copyWith =>
      __$$RegisterObjectImplCopyWithImpl<_$RegisterObjectImpl>(
          this, _$identity);
}

abstract class _RegisterObject implements RegisterObject {
  factory _RegisterObject(final String email, final String pass,
      final String userName, final String phoneNum) = _$RegisterObjectImpl;

  @override
  String get email;
  @override
  String get pass;
  @override
  String get userName;
  @override
  String get phoneNum;
  @override
  @JsonKey(ignore: true)
  _$$RegisterObjectImplCopyWith<_$RegisterObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SendMessageObject {
  String get msg => throw _privateConstructorUsedError;
  List<Message> get oldMsgs => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SendMessageObjectCopyWith<SendMessageObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendMessageObjectCopyWith<$Res> {
  factory $SendMessageObjectCopyWith(
          SendMessageObject value, $Res Function(SendMessageObject) then) =
      _$SendMessageObjectCopyWithImpl<$Res, SendMessageObject>;
  @useResult
  $Res call({String msg, List<Message> oldMsgs});
}

/// @nodoc
class _$SendMessageObjectCopyWithImpl<$Res, $Val extends SendMessageObject>
    implements $SendMessageObjectCopyWith<$Res> {
  _$SendMessageObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
    Object? oldMsgs = null,
  }) {
    return _then(_value.copyWith(
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      oldMsgs: null == oldMsgs
          ? _value.oldMsgs
          : oldMsgs // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendMessageObjectImplCopyWith<$Res>
    implements $SendMessageObjectCopyWith<$Res> {
  factory _$$SendMessageObjectImplCopyWith(_$SendMessageObjectImpl value,
          $Res Function(_$SendMessageObjectImpl) then) =
      __$$SendMessageObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String msg, List<Message> oldMsgs});
}

/// @nodoc
class __$$SendMessageObjectImplCopyWithImpl<$Res>
    extends _$SendMessageObjectCopyWithImpl<$Res, _$SendMessageObjectImpl>
    implements _$$SendMessageObjectImplCopyWith<$Res> {
  __$$SendMessageObjectImplCopyWithImpl(_$SendMessageObjectImpl _value,
      $Res Function(_$SendMessageObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
    Object? oldMsgs = null,
  }) {
    return _then(_$SendMessageObjectImpl(
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      null == oldMsgs
          ? _value._oldMsgs
          : oldMsgs // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ));
  }
}

/// @nodoc

class _$SendMessageObjectImpl implements _SendMessageObject {
  _$SendMessageObjectImpl(this.msg, final List<Message> oldMsgs)
      : _oldMsgs = oldMsgs;

  @override
  final String msg;
  final List<Message> _oldMsgs;
  @override
  List<Message> get oldMsgs {
    if (_oldMsgs is EqualUnmodifiableListView) return _oldMsgs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_oldMsgs);
  }

  @override
  String toString() {
    return 'SendMessageObject(msg: $msg, oldMsgs: $oldMsgs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageObjectImpl &&
            (identical(other.msg, msg) || other.msg == msg) &&
            const DeepCollectionEquality().equals(other._oldMsgs, _oldMsgs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, msg, const DeepCollectionEquality().hash(_oldMsgs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageObjectImplCopyWith<_$SendMessageObjectImpl> get copyWith =>
      __$$SendMessageObjectImplCopyWithImpl<_$SendMessageObjectImpl>(
          this, _$identity);
}

abstract class _SendMessageObject implements SendMessageObject {
  factory _SendMessageObject(final String msg, final List<Message> oldMsgs) =
      _$SendMessageObjectImpl;

  @override
  String get msg;
  @override
  List<Message> get oldMsgs;
  @override
  @JsonKey(ignore: true)
  _$$SendMessageObjectImplCopyWith<_$SendMessageObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
