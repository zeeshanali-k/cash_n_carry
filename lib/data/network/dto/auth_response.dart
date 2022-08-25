import 'package:cash_n_carry/data/network/dto/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse{

  UserDto? user;
  String? message;
  bool success;

  AuthResponse({this.user,this.message,required this.success});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

}