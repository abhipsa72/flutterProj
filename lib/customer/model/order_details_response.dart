// To parse this JSON data, do
//
//     final orderDetailsResponse = orderDetailsResponseFromMap(jsonString);

import 'package:grand_uae/customer/model/order.dart';

OrderDetailsResponse orderDetailsFromMap(dynamic str) =>
    OrderDetailsResponse.fromMap(str);

class OrderDetailsResponse {
  OrderDetailsResponse({
    this.order,
    this.success,
  });

  Order order;
  String success;

  factory OrderDetailsResponse.fromMap(Map<String, dynamic> json) =>
      OrderDetailsResponse(
        order: json["order"] == null ? null : Order.fromMap(json["order"]),
        success: json["success"] == null ? null : json["success"],
      );
}
