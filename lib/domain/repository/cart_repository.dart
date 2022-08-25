import 'package:cash_n_carry/domain/models/product.dart';
import 'package:cash_n_carry/domain/models/resource.dart';

abstract class CartRepository{
  Stream<Resource> addProductToCart(Product product);

  Stream<Resource> getProductCardStatus(Product product);
  Stream<Resource> getCartProducts();

  Stream<Resource> updateProductQuantity(Product product);

  Stream<Resource> deleteProduct(String id);

  Stream<Resource> placeOrder(List<Product> cartProducts);
}