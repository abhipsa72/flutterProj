import 'dart:convert';

OrderStatusResponse orderStatusFromMap(dynamic str) =>
    OrderStatusResponse.fromMap(str);

String orderStatusResponseToMap(OrderStatusResponse data) =>
    json.encode(data.toMap());

class OrderStatusResponse {
  OrderStatusResponse({
    this.success,
  });

  Success success;

  factory OrderStatusResponse.fromMap(Map<String, dynamic> json) =>
      OrderStatusResponse(
        success:
            json["success"] == null ? null : Success.fromMap(json["success"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success.toMap(),
      };
}

class Success {
  Success({
    this.orders,
  });

  List<Status> orders;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        orders: json["orders"] == null
            ? null
            : List<Status>.from(json["orders"].map((x) => Status.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "orders": orders == null
            ? null
            : List<dynamic>.from(orders.map((x) => x.toMap())),
      };
}

class Status {
  Status({
    this.orderStatusId,
    this.name,
  });

  String orderStatusId;
  String name;

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        orderStatusId:
            json["order_status_id"] == null ? null : json["order_status_id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "order_status_id": orderStatusId == null ? null : orderStatusId,
        "name": name == null ? null : name,
      };
}
