import 'package:grand_uae/customer/model/order.dart';

OrderListResponse orderListFromMap(dynamic str) =>
    OrderListResponse.fromMap(str);

class OrderListResponse {
  OrderListResponse({
    this.orders,
  });

  List<Order> orders;

  factory OrderListResponse.fromMap(Map<String, dynamic> json) =>
      OrderListResponse(
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
      );
}
