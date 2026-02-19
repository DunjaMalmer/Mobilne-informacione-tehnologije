class ProductModel {
  final String productId;
  final String productTitle;
  final double productPrice;   // double
  final String productCategory;
  final String productDescription;
  final String productImage;
  final int productQuantity;   // javljalo gresku pa smo iz string presli u int

  ProductModel({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productCategory,
    required this.productDescription,
    required this.productImage,
    required this.productQuantity,
  });
}
