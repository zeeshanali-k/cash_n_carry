import 'dart:developer';

import 'package:cash_n_carry/data/network/dto/user_dto.dart';
import 'package:cash_n_carry/domain/models/resource.dart';
import 'package:cash_n_carry/domain/repository/auth_repository.dart';
import 'package:cash_n_carry/utils/constants/app_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@named
@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl();

  @override
  Stream<Resource> loginUser(String email, String password) async* {
    try {
      var firebaseFirestore = FirebaseFirestore.instance;
      var user = await firebaseFirestore
          .collection(AppConstants.usersCollections)
          .where("email", isEqualTo: email)
          .withConverter<UserDto>(
              fromFirestore: (snapshot, _) =>
                  UserDto.fromJson(snapshot.data()!),
              toFirestore: (user, _) => user.toJson())
          .get();
      if (user.size == 0) {
        yield ResourceError(message: "Email not found");
      } else if (user.docs.first.data().password != password) {
        yield ResourceError(message: "Password does not match");
      } else {
        final userRes = user.docs.first.data();
        log(user.docs.first.id);
        userRes.id = user.docs.first.id;
        yield ResourceSuccess(userRes.toUser());
      }
      // final loginResponse = await authClient.loginUser(email, password);
      // if (!loginResponse.success) {
      // } else {
      //   yield ResourceSuccess(loginResponse.user!.toUser());
      // }
    } on Exception catch (e) {
      log(e.toString());
      yield ResourceError(message: "Server error");
    }
  }

  @override
  Stream<Resource> registerUser(
      String name, String email, String password) async* {
    log("registering");
    try {
      final usersCollection = FirebaseFirestore.instance.collection("users");
      final users = await usersCollection
          .where("email", isEqualTo: email)
          .withConverter<List<UserDto>>(
              fromFirestore: (users, _) => (users as List<Map<String, dynamic>>)
                  .map((e) => UserDto.fromJson(e))
                  .toList(),
              toFirestore: (users, _) => (users as UserDto).toJson())
          .get();
      if (users.size > 0) {
        yield ResourceError(message: "User already exists");
      } else {
        final userAddRes = await usersCollection.add(
            UserDto(email: email, name: name, password: password).toJson());
        yield ResourceSuccess(null);
      }
    } on Exception catch (e) {
      log(e.toString());
      yield ResourceError(message: "Some error occurred");
    }
  }
}
