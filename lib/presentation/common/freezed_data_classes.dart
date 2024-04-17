import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/models.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String email, String pass) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
          String email, String pass, String userName, String phoneNum) =
      _RegisterObject;
}

@freezed
class SendMessageObject with _$SendMessageObject {
  factory SendMessageObject(String msg, List<Message> oldMsgs) =
      _SendMessageObject;
}
