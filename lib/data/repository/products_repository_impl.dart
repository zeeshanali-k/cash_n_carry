import 'dart:developer';

import 'package:cash_n_carry/domain/models/product.dart';
import 'package:cash_n_carry/domain/models/resource.dart';
import 'package:cash_n_carry/domain/repository/products_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@named
@Injectable(as: ProductsRepository)
class ProductsRepositoryImpl extends ProductsRepository {
  @override
  Stream<Resource> getCategoryProducts(int categoryId) async* {
    try {
      final productsCollection =
          FirebaseFirestore.instance.collection("products");
      final productsRes = await productsCollection
          .where("category_id", isEqualTo: categoryId)
          .withConverter<Product>(
              fromFirestore: (snapshot, _) =>
                  Product.fromJson(snapshot.data()!),
              toFirestore: (products, b) => <String, Object?>{})
          .get();
      yield ResourceSuccess(
          productsRes.docs.map((e) => e.data()..id = e.id).toList());
      log("done");
    } on Exception catch (e) {
      log(e.toString());
      yield ResourceError(message: "Some error occurred");
    }
  }
}
