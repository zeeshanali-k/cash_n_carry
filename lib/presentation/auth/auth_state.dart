part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthResponse extends AuthState {
  final User? user;
  final String? error;
  AuthResponse({this.user,this.error});
}
