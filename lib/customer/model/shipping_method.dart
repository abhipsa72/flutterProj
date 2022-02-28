// To parse this JSON data, do
//
//     final shippingMethodsResponse = shippingMethodsResponseFromJson(jsonString);

ShippingMethodsResponse shippingMethodsFromJson(dynamic str) =>
    ShippingMethodsResponse.fromJson(str);

class ShippingMethodsResponse {
  ShippingMethodsResponse({
    this.shippingMethods,
  });

  List<ShippingMethod> shippingMethods;

  factory ShippingMethodsResponse.fromJson(Map<String, dynamic> json) =>
      ShippingMethodsResponse(
        shippingMethods: json["shipping_methods"] == null
            ? null
            : List<ShippingMethod>.from(json["shipping_methods"]
                .map((x) => ShippingMethod.fromJson(x))),
      );
}

class ShippingMethod {
  ShippingMethod({
    this.title,
    this.quote,
    this.sortOrder,
    this.error,
  });

  String title;
  Quote quote;
  String sortOrder;
  bool error;

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => ShippingMethod(
        title: json["title"] == null ? null : json["title"],
        quote: json["quote"] == null ? null : Quote.fromJson(json["quote"]),
        sortOrder: json["sort_order"] == null ? null : json["sort_order"],
        error: json["error"] == null ? null : json["error"],
      );
}

class Quote {
  Quote({
    this.code,
    this.title,
    this.cost,
    this.taxClassId,
    this.text,
  });

  String code;
  String title;
  dynamic cost;
  dynamic taxClassId;
  String text;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        code: json["code"] == null ? null : json["code"],
        title: json["title"] == null ? null : json["title"],
        cost: json["cost"] == null ? null : json["cost"],
        taxClassId: json["tax_class_id"] == null ? null : json["tax_class_id"],
        text: json["text"] == null ? null : json["text"],
      );
}
