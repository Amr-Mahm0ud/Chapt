import 'package:chapt/app/extentions.dart';
import 'package:chapt/data/response/responses.dart';
import 'package:chapt/domain/models/models.dart';

extension UserResponsesMapper on UserResponses {
  UserModel toDomain() {
    return UserModel(id.orEmpty(), name.orEmpty());
  }
}

extension ContactResponsesMapper on ContactsResponses {
  ContactModel toDomain() {
    return ContactModel(phone.orEmpty(), email.orEmpty());
  }
}

extension AuthenticationResponsesMappers on AuthenticationResponses {
  AuthenticationModel toDomain() {
    return AuthenticationModel(user?.toDomain(), contacts?.toDomain());
  }
}
