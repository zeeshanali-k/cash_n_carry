part of 'register_bloc.dart';

@immutable
abstract class RegisterState {
  const RegisterState();
}

class RegisterInitial extends RegisterState {}
class Registering extends RegisterState {}
class RegisterResponse extends RegisterState {
  final String? error;
  final bool success;
  const RegisterResponse({this.error,required this.success}):super();
}
