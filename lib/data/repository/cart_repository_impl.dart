import 'dart:developer';

import 'package:cash_n_carry/data/db/app_database.dart';
import 'package:cash_n_carry/domain/models/order.dart';
import 'package:cash_n_carry/domain/models/product.dart';
import 'package:cash_n_carry/domain/models/resource.dart';
import 'package:cash_n_carry/domain/repository/cart_repository.dart';
import 'package:cash_n_carry/utils/constants/app_constants.dart';
import 'package:cash_n_carry/utils/constants/pref_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@named
@Injectable(as: CartRepository)
class CartRepositoryImpl extends CartRepository {
  @override
  Stream<Resource> addProductToCart(Product product) async* {
    try {
      final appDb = await $FloorAppDatabase
          .databaseBuilder(AppConstants.appDatabase)
          .build();
      await appDb.cartDao.addProductToCart(product);
      yield ResourceSuccess(null);
    } on Exception catch (e) {
      log(e.toString());
      yield ResourceError(message: e.toString());
    }
  }

  @override
  Stream<Resource> getProductCardStatus(Product product) async* {
    try {
      final appDb = await $FloorAppDatabase
          .databaseBuilder(AppConstants.appDatabase)
          .build();
      final productCount =
          await appDb.cartDao.getProductCartStatus(product.id!);
      log("${product.id}");
      log(productCount.length.toString());
      // final products =await appDb.cartDao.getCartProducts().first;
      if (productCount.isNotEmpty) {
        yield ResourceSuccess(null);
      } else {
        yield ResourceError(message: null);
      }
    } on Exception catch (e) {
      log(e.toString());
      yield ResourceError(message: e.toString());
    }
  }

  @override
  Stream<Resource> getCartProducts() async* {
    try {
      final appDb = await $FloorAppDatabase
          .databaseBuilder(AppConstants.appDatabase)
          .build();
      final cartProducts = await appDb.cartDao.getCartProducts();
      // final products =await appDb.cartDao.getCartProducts().first;
      yield ResourceSuccess(cartProducts);
    } on Exception catch (e) {
      log(e.toString());
      yield ResourceError(message: e.toString());
    }
  }

  @override
  Stream<Resource> updateProductQuantity(Product product) async* {
    try {
      final appDb = await $FloorAppDatabase
          .databaseBuilder(AppConstants.appDatabase)
          .build();
      await appDb.cartDao.updateCartProduct(product);
      yield ResourceSuccess(null);
    } on Exception catch (e) {
      log(e.toString());
      yield ResourceError(message: e.toString());
    }
  }

  @override
  Stream<Resource> deleteProduct(String id) async* {
    try {
      final appDb = await $FloorAppDatabase
          .databaseBuilder(AppConstants.appDatabase)
          .build();
      await appDb.cartDao.deleteProductFromCart(id);
      yield ResourceSuccess(null);
    } on Exception catch (e) {
      log(e.toString());
      yield ResourceError(message: e.toString());
    }
  }

  @override
  Stream<Resource> placeOrder(List<Product> cartProducts) async* {
    try {
      final sp = await SharedPreferences.getInstance();
      var ordersCollection = FirebaseFirestore.instance.collection("orders");
      log(Order(
        products: cartProducts,
        userId: sp.getString(PrefContants.userId)!,
      ).toJson().toString());
      final addRes = await ordersCollection.add(Order(
        products: cartProducts,
        userId: sp.getString(PrefContants.userId)!,
      ).toJson());

      final appDb = await $FloorAppDatabase
          .databaseBuilder(AppConstants.appDatabase)
          .build();
      await appDb.cartDao.deleteAllProducts();
      yield ResourceSuccess(null);
    } on Exception catch (e) {
      log(e.toString());
      yield ResourceError(message: "Some error occurred");
    }
  }
}
