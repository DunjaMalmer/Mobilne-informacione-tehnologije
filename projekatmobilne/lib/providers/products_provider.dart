import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projekatmobilne/models/product_model.dart';

class ProductsProvider with ChangeNotifier {
  final List<ProductModel> _products = [];
  final productDb = FirebaseFirestore.instance.collection("products");

  List<ProductModel> get getProducts => _products;

  ProductModel? findByProductId(String productId) {
    try {
      return _products.firstWhere((element) => element.productId == productId);
    } catch (_) {
      return null;
    }
  }

  List<ProductModel> findByCategory({required String categoryName}) {
    return _products
        .where((element) =>
            element.productCategory.toLowerCase() == categoryName.toLowerCase())
        .toList();
  }

  List<ProductModel> searchQuery({
    required String searchText,
    required List<ProductModel> passedList,
  }) {
    return passedList
        .where((element) => element.productTitle
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
  }

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final productSnapshot =
          await productDb.get();

      _products
        ..clear()
        ..addAll(
          productSnapshot.docs.map((element) => ProductModel.fromFirestore(element)),
        );
      notifyListeners();
      return _products;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ProductModel>> fetchProductsStream() {
    return productDb.orderBy("createdAt", descending: true).snapshots().map(
      (snapshot) {
        _products
          ..clear()
          ..addAll(
            snapshot.docs.map((element) => ProductModel.fromFirestore(element)),
          );
        return _products;
      },
    );
  }

  void clearLocalProducts() {
    _products.clear();
    notifyListeners();
  }
}
