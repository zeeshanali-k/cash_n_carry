part of 'product_details_bloc.dart';

@immutable
abstract class ProductDetailsEvent {}

class AddProductToCart extends ProductDetailsEvent{
  final Product product;
  AddProductToCart({required this.product});
}

class GetProductCartStatus extends ProductDetailsEvent{
  final Product product;

  GetProductCartStatus({required this.product});

}
