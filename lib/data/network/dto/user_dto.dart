import 'package:cash_n_carry/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto{

  String? id;
  late String name;
  String? profile;
  late String email;
  late String password;

  UserDto({required this.name,required this.password,required this.email,this.profile,this.id});

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  User toUser(){
    return User(name: name,email: email,profile: profile,id: id!,password: password);
  }

}