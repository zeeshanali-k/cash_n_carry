part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {
}

class RegisterUserEvent extends RegisterEvent{
  final String email;
  final String password;
  final String name;
  RegisterUserEvent({required this.email,required this.password,required this.name});
}
