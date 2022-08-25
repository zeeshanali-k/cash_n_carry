part of 'category_products_bloc.dart';

@immutable
abstract class CategoryProductsState {}

class CategoryProductsInitial extends CategoryProductsState {}
class LoadingCategoryProducts extends CategoryProductsState {}
class GetCategoryProductsRes extends CategoryProductsState {
  final bool isSuccess;
  final List<Product>? products;
  GetCategoryProductsRes({required this.isSuccess,this.products});
}
