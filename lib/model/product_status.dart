import 'dart:convert';

import 'package:zel_app/model/product.dart';

ProductStatus productStatusFromJson(dynamic str) => ProductStatus.fromMap(str);

String productStatusToJson(ProductStatus data) => json.encode(data.toMap());

class ProductStatus {
  bool status;
  Product product;

  ProductStatus({
    this.status,
    this.product,
  });

  factory ProductStatus.fromMap(Map<String, dynamic> data) => ProductStatus(
        status: data["status"] == null ? false : data["status"],
        product: data["productData"] == null
            ? null
            : Product.fromMap(data["productData"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "productData": product == null ? null : product.toMap(),
      };
}
