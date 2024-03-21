import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponses {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
}

@JsonSerializable()
class UserResponses {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  UserResponses(this.id, this.name);

  //from json
  factory UserResponses.fromJson(Map<String, dynamic> json) =>
      _$UserResponsesFromJson(json);
  //to json
  Map<String, dynamic> toJson() => _$UserResponsesToJson(this);
}

@JsonSerializable()
class ContactsResponses {
  @JsonKey(name: 'phone')
  int? phone;
  @JsonKey(name: 'email')
  String? email;
  ContactsResponses(this.phone, this.email);
  //from json
  factory ContactsResponses.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponsesFromJson(json);
  //to json
  Map<String, dynamic> toJson() => _$ContactsResponsesToJson(this);
}

@JsonSerializable()
class AuthenticationResponses extends BaseResponses {
  @JsonKey(name: 'user')
  UserResponses? user;
  @JsonKey(name: 'contacts')
  ContactsResponses? contacts;

  AuthenticationResponses(this.user, this.contacts);

  //from json
  factory AuthenticationResponses.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponsesFromJson(json);
  //to json
  Map<String, dynamic> toJson() => _$AuthenticationResponsesToJson(this);
}
