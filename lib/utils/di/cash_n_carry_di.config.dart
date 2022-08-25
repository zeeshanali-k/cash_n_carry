// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i14;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/repository/auth_repository_impl.dart' as _i4;
import '../../data/repository/cart_repository_impl.dart' as _i6;
import '../../data/repository/products_repository_impl.dart' as _i9;
import '../../domain/repository/auth_repository.dart' as _i3;
import '../../domain/repository/cart_repository.dart' as _i5;
import '../../domain/repository/products_repository.dart' as _i8;
import '../../presentation/auth/auth_bloc.dart' as _i11;
import '../../presentation/auth/register/register_bloc.dart' as _i10;
import '../../presentation/cart/cart_bloc.dart' as _i12;
import '../../presentation/categories_n_products/category_products/category_products_bloc.dart'
    as _i13;
import '../../presentation/categories_n_products/product_details/product_details_bloc.dart'
    as _i7;
import 'app_module.dart' as _i15; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.factory<_i3.AuthRepository>(() => _i4.AuthRepositoryImpl(),
      instanceName: 'AuthRepositoryImpl');
  gh.factory<_i5.CartRepository>(() => _i6.CartRepositoryImpl(),
      instanceName: 'CartRepositoryImpl');
  gh.factory<_i7.ProductDetailsBloc>(() => _i7.ProductDetailsBloc(
      get<_i5.CartRepository>(instanceName: 'CartRepositoryImpl')));
  gh.factory<_i8.ProductsRepository>(() => _i9.ProductsRepositoryImpl(),
      instanceName: 'ProductsRepositoryImpl');
  gh.factory<_i10.RegisterBloc>(() => _i10.RegisterBloc(
      get<_i3.AuthRepository>(instanceName: 'AuthRepositoryImpl')));
  gh.factory<String>(() => appModule.baseUrl, instanceName: 'baseUrl');
  gh.factory<_i11.AuthBloc>(() => _i11.AuthBloc(
      get<_i3.AuthRepository>(instanceName: 'AuthRepositoryImpl')));
  gh.factory<_i12.CartBloc>(() => _i12.CartBloc(
      get<_i5.CartRepository>(instanceName: 'CartRepositoryImpl')));
  gh.factory<_i13.CategoryProductsBloc>(() => _i13.CategoryProductsBloc(
      get<_i8.ProductsRepository>(instanceName: 'ProductsRepositoryImpl')));
  gh.lazySingleton<_i14.Dio>(
      () => appModule.dio(get<String>(instanceName: 'baseUrl')));
  return get;
}

class _$AppModule extends _i15.AppModule {}
