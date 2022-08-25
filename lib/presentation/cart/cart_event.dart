part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}


class GetCartProducts extends CartEvent{
  GetCartProducts();
}

class QuantityChanged extends CartEvent{
  final int quantity;
  final int pos;
  QuantityChanged({required this.quantity,required this.pos});
}

class ProductDeleted extends CartEvent{
  final int pos;
  ProductDeleted({required this.pos});
}

class PlaceOrder extends CartEvent{
  PlaceOrder();
}
