import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule{
// You can register named preemptive types like follows
  @Named("baseUrl")
  String get baseUrl => 'http://192.168.8.110:8000/api/';

  // url here will be injected
  @lazySingleton
  Dio dio(@Named('baseUrl') String url) => Dio(BaseOptions(baseUrl: url));

}