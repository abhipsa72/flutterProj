// To parse this JSON data, do
//
//     final cartListResponse = cartListResponseFromMap(jsonString);

import 'package:grand_uae/customer/model/product.dart';

CartListResponse cartListFromMap(dynamic str) => CartListResponse.fromMap(str);

class CartListResponse {
  CartListResponse({
    this.success,
    this.minimumOrderTotal,
    this.vouchers,
    this.totals,
  });

  Success success;
  dynamic minimumOrderTotal;
  List<dynamic> vouchers;
  List<Total> totals;

  factory CartListResponse.fromMap(Map<String, dynamic> json) =>
      CartListResponse(
        success: json["success"] == null
            ? null
            : Success.fromMap(
                json["success"],
              ),
        minimumOrderTotal: json["minimum_order_total"] == null
            ? null
            : json["minimum_order_total"],
        vouchers: json["vouchers"] == null
            ? null
            : List<dynamic>.from(
                json["vouchers"].map((x) => x),
              ),
        totals: json["totals"] == null
            ? null
            : List<Total>.from(
                json["totals"].map(
                  (x) => Total.fromMap(x),
                ),
              ),
      );
}

class Success {
  Success({
    this.products,
  });

  List<Product> products;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"].map((x) => Product.fromMap(x))),
      );
}

class Total {
  Total({
    this.title,
    this.text,
  });

  String title;
  String text;

  factory Total.fromMap(Map<String, dynamic> json) => Total(
        title: json["title"] == null ? null : json["title"],
        text: json["text"] == null ? null : json["text"],
      );
}

/*
class Product {
  Product({
    this.cartId,
    this.productId,
    this.image,
    this.name,
    this.model,
    this.option,
    this.quantity,
    this.stock,
    this.shipping,
    this.price,
    this.total,
    this.reward,
  });


  String productId;
  String image;
  String name;
  String model;
  List<dynamic> option;
  String quantity;
  bool stock;
  String shipping;
  String price;
  String total;
  int reward;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        cartId: json["cart_id"] == null ? null : json["cart_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        image: json["image"] == null ? null : json["image"],
        name: json["name"] == null ? null : json["name"],
        model: json["model"] == null ? null : json["model"],
        option: json["option"] == null
            ? null
            : List<dynamic>.from(json["option"].map((x) => x)),
        quantity: json["quantity"] == null ? null : json["quantity"],
        stock: json["stock"] == null ? null : json["stock"],
        shipping: json["shipping"] == null ? null : json["shipping"],
        price: json["price"] == null ? null : json["price"],
        total: json["total"] == null ? null : json["total"],
        reward: json["reward"] == null ? null : json["reward"],
      );
}*/
