import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cash_n_carry/data/repository/cart_repository_impl.dart';
import 'package:cash_n_carry/domain/models/product.dart';
import 'package:cash_n_carry/domain/models/resource.dart';
import 'package:cash_n_carry/domain/repository/cart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';

part 'cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(@Named.from(CartRepositoryImpl) CartRepository cartRepository)
      : super(const CartInitial()) {
    on<CartEvent>((event, emit) {
      if (event is GetCartProducts) {
        emit(const LoadingState(cartProducts: null));
        return handleGetCartProducts(emit, cartRepository);
      } else if (event is QuantityChanged) {
        return handleQuantityChanged(event, emit, cartRepository);
      } else if (event is ProductDeleted) {
        return handleProductDeleted(event, emit, cartRepository);
      }else if(event is PlaceOrder){
        emit(LoadingState(cartProducts: state.cartProducts));
        return handlePlaceOrder(emit,cartRepository);
      }
    });
  }

  Future<void> handleGetCartProducts(
      Emitter<CartState> emit, CartRepository cartRepository) {
    return emit.forEach(cartRepository.getCartProducts(), onData: (response) {
      if (response is ResourceSuccess) {
        return GetCartProductsRes(
            cartProducts: response.data! as List<Product>);
      } else {
        return GetCartProductsRes(cartProducts: List.empty());
      }
    });
  }

  Future<void> handleQuantityChanged(QuantityChanged event,
      Emitter<CartState> emit, CartRepository cartRepository) {
    final productsListTemp = (state as GetCartProductsRes).cartProducts;
    var product = productsListTemp![event.pos];
    product.quantity = event.quantity;
    productsListTemp[event.pos] = product;
    return emit.forEach(cartRepository.updateProductQuantity(product),
        onData: (response) {
      if (response is ResourceSuccess) {
        return GetCartProductsRes(cartProducts: productsListTemp);
      }else{
        return GetCartProductsRes(cartProducts: List.empty());
      }
    });
  }

  Future<void> handleProductDeleted(ProductDeleted event, Emitter<CartState> emit, CartRepository cartRepository) {
    final productsListTemp = (state as GetCartProductsRes).cartProducts;
    var product = productsListTemp![event.pos];
    productsListTemp.removeAt(event.pos);
    return emit.forEach(cartRepository.deleteProduct(product.id!), onData: (response){
      if(response is ResourceSuccess){
        return GetCartProductsRes(cartProducts: productsListTemp);
      }else{
        return GetCartProductsRes(cartProducts: List.empty());
      }
    });
  }

  Future<void> handlePlaceOrder(Emitter<CartState> emit, CartRepository cartRepository) {
    return emit.forEach(cartRepository.placeOrder(state.cartProducts!), onData: (response){
      if(response is ResourceSuccess){
        return GetCartProductsRes(cartProducts: List<Product>.empty());
      }else{
        return GetCartProductsRes(cartProducts: state.cartProducts);
      }
    });
  }

}
