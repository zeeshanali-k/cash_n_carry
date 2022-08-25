// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      name: json['name'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      profile: json['profile'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile': instance.profile,
      'email': instance.email,
      'password': instance.password,
    };
