// To parse this JSON data, do
//
//     final productComapre = productComapreFromJson(jsonString);

import 'package:grand_uae/customer/model/product.dart';

ProductCompareResponse compareFromJson(dynamic str) =>
    ProductCompareResponse.fromJson(str);

class ProductCompareResponse {
  ProductCompareResponse({
    this.success,
  });

  Success success;

  factory ProductCompareResponse.fromJson(Map<String, dynamic> json) =>
      ProductCompareResponse(
        success:
            json["success"] == null ? null : Success.fromJson(json["success"]),
      );
}

class Success {
  Success({
    this.products,
  });

  List<Product> products;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"].map((x) => Product.fromMap(x))),
      );
}
