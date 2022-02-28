import 'dart:convert';

import 'package:zel_app/model/product.dart';

StoreFilter storeFilterFromJson(dynamic str) => StoreFilter.fromMap(str);

String storeFilterToJson(StoreFilter data) => json.encode(data.toMap());

class StoreFilter {
  String message;
  List<Product> product;

  StoreFilter({
    this.message,
    this.product,
  });

  factory StoreFilter.fromMap(Map<String, dynamic> data) => StoreFilter(
        message: data["message"] == null ? false : data["message"],
        product: data["salesalarms"] == null
            ? null
            : List<Product>.from(
                data["salesalarms"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "salesalarms": product == null
            ? null
            : List<dynamic>.from(product.map((x) => x.toMap())),
      };
}
