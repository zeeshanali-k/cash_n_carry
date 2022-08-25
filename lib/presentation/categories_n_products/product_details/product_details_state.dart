part of 'product_details_bloc.dart';

@immutable
abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}
class AddingProductToCart extends ProductDetailsState {}

class AddProductToCartResponse extends ProductDetailsState{
  final bool success;
  AddProductToCartResponse({required this.success});
}
