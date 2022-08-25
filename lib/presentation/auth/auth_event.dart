part of 'auth_bloc.dart';

abstract class AuthEvent {
  String email;
  String password;

  AuthEvent({required this.email,required this.password});

}

class LoginEvent extends AuthEvent{
  LoginEvent({required String email,required String password}) : super(email: email,password: password);
}

class RegisterEvent extends AuthEvent{
  String name;
  RegisterEvent({required String email,required String password,required this.name})
      : super(email: email,password: password);
}