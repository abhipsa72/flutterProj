// To parse this JSON data, do
//
//     final paymentMethodsResponse = paymentMethodsResponseFromJson(jsonString);

PaymentMethodsResponse paymentMethodsFromJson(dynamic str) =>
    PaymentMethodsResponse.fromJson(str);

class PaymentMethodsResponse {
  PaymentMethodsResponse({
    this.paymentMethods,
  });

  List<PaymentMethod> paymentMethods;

  factory PaymentMethodsResponse.fromJson(Map<String, dynamic> json) =>
      PaymentMethodsResponse(
        paymentMethods: json["payment_methods"] == null
            ? null
            : List<PaymentMethod>.from(
                json["payment_methods"].map((x) => PaymentMethod.fromJson(x))),
      );
}

class PaymentMethod {
  PaymentMethod({
    this.code,
    this.title,
    this.terms,
    this.sortOrder,
  });

  String code;
  String title;
  String terms;
  String sortOrder;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        code: json["code"] == null ? null : json["code"],
        title: json["title"] == null ? null : json["title"],
        terms: json["terms"] == null ? null : json["terms"],
        sortOrder: json["sort_order"] == null ? null : json["sort_order"],
      );
}
