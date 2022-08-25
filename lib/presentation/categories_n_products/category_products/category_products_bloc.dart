import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cash_n_carry/data/repository/products_repository_impl.dart';
import 'package:cash_n_carry/domain/models/product.dart';
import 'package:cash_n_carry/domain/models/resource.dart';
import 'package:cash_n_carry/domain/repository/products_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'category_products_event.dart';

part 'category_products_state.dart';

@injectable
class CategoryProductsBloc
    extends Bloc<CategoryProductsEvent, CategoryProductsState> {
  CategoryProductsBloc(
      @Named.from(ProductsRepositoryImpl) ProductsRepository productsRepository)
      : super(LoadingCategoryProducts()) {
    on<CategoryProductsEvent>((event, emit) {
      if (event is GetCategoryProducts) {
        emit(LoadingCategoryProducts());
        return handleGetCategoryProductsEvet(event, emit, productsRepository);
      }
    });
  }

  Future<void> handleGetCategoryProductsEvet(
      GetCategoryProducts event,
      Emitter<CategoryProductsState> emit,
      ProductsRepository productsRepository) {
    return emit
        .forEach(productsRepository.getCategoryProducts(event.categoryId),
            onData: (response) {
      if (response is ResourceSuccess) {
        return GetCategoryProductsRes(isSuccess: true,products: response.data as List<Product>);
      } else {
        return GetCategoryProductsRes(isSuccess: false);
      }
    });
  }
}
