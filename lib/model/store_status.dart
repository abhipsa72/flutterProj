import 'dart:convert';

import 'package:zel_app/model/store_product.dart';

StoreStatus storeStatusFromJson(dynamic str) => StoreStatus.fromMap(str);

String storeStatusToJson(StoreStatus data) => json.encode(data.toMap());

class StoreStatus {
  bool status;
  StoreProduct product;

  StoreStatus({
    this.status,
    this.product,
  });

  factory StoreStatus.fromMap(Map<String, dynamic> data) => StoreStatus(
    status: data["status"] == null ? false : data["status"],
    product: data["productData"] == null
        ? null
        : StoreProduct.fromMap(data["productData"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status,
    "productData": product == null ? null : product.toMap(),
  };
}