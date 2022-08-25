
import 'package:cash_n_carry/domain/models/product.dart';
import 'package:floor/floor.dart';

@dao
abstract class CartDao{

  @Query("SELECT * FROM products")
  Future<List<Product>> getCartProducts();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addProductToCart(Product product);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateCartProduct(Product product);

  @Query("DELETE FROM products WHERE id=:id")
  Future<void> deleteProductFromCart(String id);

  @Query("SELECT * FROM products WHERE id=:id")
  Future<List<Product>> getProductCartStatus(String id);

  @Query("DELETE FROM products")
  Future<void> deleteAllProducts();
}