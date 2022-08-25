import 'package:cash_n_carry/domain/models/resource.dart';

abstract class ProductsRepository{
  Stream<Resource> getCategoryProducts(int categoryId);
}