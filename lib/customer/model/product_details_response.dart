import 'package:grand_uae/customer/model/product.dart';

ProductDetailsResponse productDetailsFromMap(dynamic str) =>
    ProductDetailsResponse.fromMap(str);

class ProductDetailsResponse {
  ProductDetailsResponse({
    this.success,
  });

  Success success;

  factory ProductDetailsResponse.fromMap(Map<String, dynamic> json) =>
      ProductDetailsResponse(
        success: json["success"] == null
            ? null
            : Success.fromMap(
                json["success"],
              ),
      );
}

class Success {
  Success({
    this.product,
  });

  Product product;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        product: json["product"] == null
            ? null
            : Product.fromMap(
                json["product"],
              ),
      );
}
