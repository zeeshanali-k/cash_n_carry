part of 'cart_bloc.dart';

@immutable
abstract class CartState {


  final List<Product>? cartProducts;

  const CartState({required this.cartProducts});

}

class CartInitial extends CartState {
  const CartInitial():super(cartProducts: null);
}

class LoadingState extends CartState{

  const LoadingState({required List<Product>? cartProducts}):super(cartProducts: cartProducts);

}

class GetCartProductsRes extends CartState{
  const GetCartProductsRes({required cartProducts}):super(cartProducts: cartProducts);
}