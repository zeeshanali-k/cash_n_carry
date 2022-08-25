part of 'category_products_bloc.dart';

@immutable
abstract class CategoryProductsEvent {}

class GetCategoryProducts extends CategoryProductsEvent{
  final int categoryId;
  GetCategoryProducts({required this.categoryId});
}
