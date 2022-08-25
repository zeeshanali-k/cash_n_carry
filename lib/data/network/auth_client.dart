// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:retrofit/retrofit.dart';
//
// import 'dto/auth_response.dart';
//
// part 'auth_client.g.dart';
//
// @injectable
// @RestApi(baseUrl: "http://192.168.8.110:8000/api/")
// abstract class AuthClient {
//
//   @factoryMethod
//   factory AuthClient(Dio dio,{@Named("baseUrl")String baseUrl}) = _AuthClient;
//
//   @POST("login-user")
//   Future<AuthResponse> loginUser(
//     @Query("email") String email,
//     @Query("password") String password,
//   );
//
//   @POST("register-user")
//   Future<List<AuthResponse>> registerUser(
//     @Query("name") String name,
//     @Query("email") String email,
//     @Query("password") String password,
//   );
//
// }
//
