import 'package:flutter/material.dart';
import 'package:projekatmobilne/models/product_model.dart';
import 'package:projekatmobilne/services/assets_manager.dart';
import 'package:uuid/uuid.dart';

class ProductsProvider with ChangeNotifier {

  List<ProductModel> get getProducts {
    return _products;
  }

  ProductModel? findByProductId(String productId) {
    try {
      return _products.firstWhere((element) => element.productId == productId);
    } catch (e) {
      return null;
    }
  }

  List<ProductModel> findByCategory({required String categoryName}) {
    return _products
        .where((element) =>
            element.productCategory.toLowerCase() ==
            categoryName.toLowerCase())
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

  final List<ProductModel> _products = [

    /// TORTE
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Čoko malina torta",
      productPrice: 2400.0,
      productCategory: "Torte",
      productDescription:
          "Bogata čokolada i sveža malina u savršenom spoju ukusa.",
      productImage:
          "${AssetsManager.imagePath}/cokomalina.jpg",
      productQuantity: 10,
    ),

    /// MAKARONSI
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Pistać makaronsi",
      productPrice: 690.0,
      productCategory: "Makaronsi",
      productDescription:
          "Omiljeni izbor kupaca sa kremastim pistać filom.",
      productImage:
          "${AssetsManager.imagePath}/pistaci.jpg",
      productQuantity: 25,
    ),

    /// MINI POSLASTICE
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Mini cheesecake",
      productPrice: 480.0,
      productCategory: "Mini poslastice",
      productDescription:
          "Lagan i osvežavajući desert idealan uz kafu.",
      productImage:
          "${AssetsManager.imagePath}/mini.jpg",
      productQuantity: 30,
    ),
  ];
}
