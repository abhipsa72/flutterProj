import 'dart:convert';

OrdersResponse ordersFromMap(dynamic str) => OrdersResponse.fromMap(str);

String ordersResponseToMap(OrdersResponse data) => json.encode(data.toMap());

class OrdersResponse {
  OrdersResponse({
    this.success,
  });

  Success success;

  factory OrdersResponse.fromMap(Map<String, dynamic> json) => OrdersResponse(
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

  List<Order> orders;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        orders: json["orders"] == null
            ? null
            : List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "orders": orders == null
            ? null
            : List<dynamic>.from(orders.map((x) => x.toMap())),
      };
}

class Order {
  Order({
    this.orderId,
    this.customer,
    this.orderStatus,
    this.shippingCode,
    this.total,
    this.currencyCode,
    this.currencyValue,
    this.dateAdded,
    this.dateModified,
  });

  String orderId;
  String customer;
  OrderStatus orderStatus;
  ShippingCode shippingCode;
  String total;
  CurrencyCode currencyCode;
  String currencyValue;
  DateTime dateAdded;
  DateTime dateModified;

  String totalPrice() =>
      '${currencyCodeValues.reverse[currencyCode]} ${double.parse(total).toStringAsFixed(2)}';

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        orderId: json["order_id"] == null ? null : json["order_id"],
        customer: json["customer"] == null ? null : json["customer"],
        orderStatus: json["order_status"] == null
            ? null
            : orderStatusValues.map[json["order_status"]],
        shippingCode: json["shipping_code"] == null
            ? null
            : shippingCodeValues.map[json["shipping_code"]],
        total: json["total"] == null ? null : json["total"],
        currencyCode: json["currency_code"] == null
            ? null
            : currencyCodeValues.map[json["currency_code"]],
        currencyValue:
            json["currency_value"] == null ? null : json["currency_value"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
      );

  Map<String, dynamic> toMap() => {
        "order_id": orderId == null ? null : orderId,
        "customer": customer == null ? null : customer,
        "order_status":
            orderStatus == null ? null : orderStatusValues.reverse[orderStatus],
        "shipping_code": shippingCode == null
            ? null
            : shippingCodeValues.reverse[shippingCode],
        "total": total == null ? null : total,
        "currency_code": currencyCode == null
            ? null
            : currencyCodeValues.reverse[currencyCode],
        "currency_value": currencyValue == null ? null : currencyValue,
        "date_added": dateAdded == null ? null : dateAdded.toIso8601String(),
        "date_modified":
            dateModified == null ? null : dateModified.toIso8601String(),
      };
}

enum CurrencyCode { AED, USD }

final currencyCodeValues =
    EnumValues({"AED": CurrencyCode.AED, "USD": CurrencyCode.USD});

enum OrderStatus { COMPLETE, DENIED, CANCELED, PENDING, PROCESSING }

final orderStatusValues = EnumValues({
  "Canceled": OrderStatus.CANCELED,
  "Complete": OrderStatus.COMPLETE,
  "Denied": OrderStatus.DENIED,
  "Pending": OrderStatus.PENDING,
  "Processing": OrderStatus.PROCESSING
});

enum ShippingCode { FLAT_FLAT, TOTAL_BASED_TOTAL_BASED_0 }

final shippingCodeValues = EnumValues({
  "flat.flat": ShippingCode.FLAT_FLAT,
  "total_based.total_based_0": ShippingCode.TOTAL_BASED_TOTAL_BASED_0
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
