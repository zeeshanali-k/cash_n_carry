import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cash_n_carry/data/repository/cart_repository_impl.dart';
import 'package:cash_n_carry/domain/models/product.dart';
import 'package:cash_n_carry/domain/models/resource.dart';
import 'package:cash_n_carry/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'product_details_event.dart';

part 'product_details_state.dart';

@injectable
class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc(
      @Named.from(CartRepositoryImpl) CartRepository cartRepository)
      : super(ProductDetailsInitial()) {
    on<ProductDetailsEvent>((event, emit) {
      if (event is AddProductToCart) {
        emit(AddingProductToCart());
        return handleAddProductToCartEvent(event, emit, cartRepository);
      } else if (event is GetProductCartStatus) {
        emit(AddingProductToCart());
        return handleGetProductCartStatus(event, emit, cartRepository);
      }
    });
  }

  Future<void> handleAddProductToCartEvent(AddProductToCart event,
      Emitter<ProductDetailsState> emit, CartRepository cartRepository) {
    return emit.forEach(cartRepository.addProductToCart(event.product),
        onData: (response) {
      if (response is ResourceSuccess) {
        return AddProductToCartResponse(success: true);
      } else {
        return AddProductToCartResponse(success: false);
      }
    });
  }

  Future<void> handleGetProductCartStatus(GetProductCartStatus event,
      Emitter<ProductDetailsState> emit, CartRepository cartRepository) {
    return emit.forEach(cartRepository.getProductCardStatus(event.product), onData: (response) {
      if (response is ResourceSuccess) {
        return AddProductToCartResponse(success: true);
      } else {
        return AddProductToCartResponse(success: false);
      }
    });
  }
}
