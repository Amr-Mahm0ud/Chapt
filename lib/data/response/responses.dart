import 'package:google_generative_ai/google_generative_ai.dart';
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
  String? phone;
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

@JsonSerializable()
class MessageResponse {
  @JsonKey(name: 'text')
  String? message;
  @JsonKey(name: 'role')
  String? role;

  MessageResponse(this.message, this.role);
  //from json
  factory MessageResponse.fromResponse(GenerateContentResponse content) =>
      _$MessageResponseFromResponse(content);
  //to json
  Content toContent() => _$MessageResponseToContent(this);
}
