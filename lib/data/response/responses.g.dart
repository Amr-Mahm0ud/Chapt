// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponses _$BaseResponsesFromJson(Map<String, dynamic> json) =>
    BaseResponses()
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponsesToJson(BaseResponses instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

UserResponses _$UserResponsesFromJson(Map<String, dynamic> json) =>
    UserResponses(
      json['id'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$UserResponsesToJson(UserResponses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ContactsResponses _$ContactsResponsesFromJson(Map<String, dynamic> json) =>
    ContactsResponses(
      json['phone'] as String?,
      json['email'] as String?,
    );

Map<String, dynamic> _$ContactsResponsesToJson(ContactsResponses instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'email': instance.email,
    };

AuthenticationResponses _$AuthenticationResponsesFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponses(
      json['user'] == null
          ? null
          : UserResponses.fromJson(json['user'] as Map<String, dynamic>),
      json['contacts'] == null
          ? null
          : ContactsResponses.fromJson(
              json['contacts'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponsesToJson(
        AuthenticationResponses instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'user': instance.user,
      'contacts': instance.contacts,
    };
