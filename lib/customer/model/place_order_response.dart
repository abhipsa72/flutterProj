// To parse this JSON data, do
//
//     final placeOrderResponse = placeOrderResponseFromMap(jsonString);

PlaceOrderResponse placeOrderFromMap(dynamic str) =>
    PlaceOrderResponse.fromMap(str);

class PlaceOrderResponse {
  PlaceOrderResponse({
    this.success,
    this.orderId,
  });

  Success success;
  int orderId;

  factory PlaceOrderResponse.fromMap(Map<String, dynamic> json) =>
      PlaceOrderResponse(
        success:
            json["success"] == null ? null : Success.fromMap(json["success"]),
        orderId: json["order_id"] == null ? null : json["order_id"],
      );
}

class Success {
  Success({
    this.message,
  });

  String message;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        message: json["message"] == null ? null : json["message"],
      );
}
