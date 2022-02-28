// To parse this JSON data, do
//
//     final orderProductsResponse = orderProductsResponseFromMap(jsonString);

import 'dart:convert';

OrderProductsResponse orderProductsFromMap(dynamic str) =>
    OrderProductsResponse.fromMap(str);

String orderProductsResponseToMap(OrderProductsResponse data) =>
    json.encode(data.toMap());

class OrderProductsResponse {
  OrderProductsResponse({
    this.success,
  });

  Success success;

  factory OrderProductsResponse.fromMap(Map<String, dynamic> json) =>
      OrderProductsResponse(
        success:
            json["success"] == null ? null : Success.fromMap(json["success"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success.toMap(),
      };
}

class Success {
  Success({
    this.products,
  });

  List<OrderProduct> products;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        products: json["products"] == null
            ? null
            : List<OrderProduct>.from(
                json["products"].map((x) => OrderProduct.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toMap())),
      };
}

class OrderProduct {
  OrderProduct({
    this.orderProductId,
    this.orderId,
    this.productId,
    this.name,
    this.model,
    this.quantity,
    this.price,
    this.total,
    this.tax,
    this.reward,
  });

  String orderProductId;
  String orderId;
  String productId;
  String name;
  String model;
  String quantity;
  String price;
  String total;
  String tax;
  String reward;

  factory OrderProduct.fromMap(Map<String, dynamic> json) => OrderProduct(
        orderProductId:
            json["order_product_id"] == null ? null : json["order_product_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        name: json["name"] == null ? null : json["name"],
        model: json["model"] == null ? null : json["model"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"] == null ? null : json["price"],
        total: json["total"] == null ? null : json["total"],
        tax: json["tax"] == null ? null : json["tax"],
        reward: json["reward"] == null ? null : json["reward"],
      );

  Map<String, dynamic> toMap() => {
        "order_product_id": orderProductId == null ? null : orderProductId,
        "order_id": orderId == null ? null : orderId,
        "product_id": productId == null ? null : productId,
        "name": name == null ? null : name,
        "model": model == null ? null : model,
        "quantity": quantity == null ? null : quantity,
        "price": price == null ? null : price,
        "total": total == null ? null : total,
        "tax": tax == null ? null : tax,
        "reward": reward == null ? null : reward,
      };
}
