import 'package:cash_n_carry/domain/models/resource.dart';

abstract class AuthRepository{
  Stream<Resource> loginUser(String email,String password);
  Stream<Resource> registerUser(String name,String email,String password);
}