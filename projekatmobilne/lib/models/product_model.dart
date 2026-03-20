import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String productTitle;
  final double productPrice;
  final String productCategory;
  final String productDescription;
  final String productImage;
  final int productQuantity;
  final Timestamp? createdAt;

  ProductModel({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productCategory,
    required this.productDescription,
    required this.productImage,
    required this.productQuantity,
    this.createdAt,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final rawPrice = data['productPrice'];
    final rawQuantity = data['productQuantity'];

    return ProductModel(
      productId: data['productId']?.toString() ?? '',
      productTitle: data['productTitle']?.toString() ?? '',
      productPrice: double.tryParse(rawPrice.toString()) ?? 0.0,
      productCategory: data['productCategory']?.toString() ?? '',
      productDescription: data['productDescription']?.toString() ?? '',
      productImage: data['productImage']?.toString() ?? '',
      productQuantity: int.tryParse(rawQuantity.toString()) ?? 0,
      createdAt: data['createdAt'] as Timestamp?,
    );
  }
}
