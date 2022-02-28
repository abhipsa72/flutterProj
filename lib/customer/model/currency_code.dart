// To parse this JSON data, do
//
//     final currencyResponse = currencyResponseFromJson(jsonString);

CurrencyListResponse currencyListFromMap(dynamic str) =>
    CurrencyListResponse.fromJson(str);

class CurrencyListResponse {
  CurrencyListResponse({
    this.success,
  });

  Success success;

  factory CurrencyListResponse.fromJson(Map<String, dynamic> json) =>
      CurrencyListResponse(
        success:
            json["success"] == null ? null : Success.fromJson(json["success"]),
      );
}

class Success {
  Success({
    this.currencies,
  });

  List<Currency> currencies;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        currencies: json["currencies"] == null
            ? null
            : List<Currency>.from(
                json["currencies"].map((x) => Currency.fromJson(x))),
      );
}

class Currency {
  Currency({
    this.currencyId,
    this.title,
    this.code,
    this.symbolLeft,
    this.symbolRight,
    this.decimalPlace,
    this.value,
    this.status,
    this.dateModified,
  });

  String currencyId;
  String title;
  String code;
  String symbolLeft;
  String symbolRight;
  String decimalPlace;
  String value;
  String status;
  DateTime dateModified;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        currencyId: json["currency_id"] == null ? null : json["currency_id"],
        title: json["title"] == null ? null : json["title"],
        code: json["code"] == null ? null : json["code"],
        symbolLeft: json["symbol_left"] == null ? null : json["symbol_left"],
        symbolRight: json["symbol_right"] == null ? null : json["symbol_right"],
        decimalPlace:
            json["decimal_place"] == null ? null : json["decimal_place"],
        value: json["value"] == null ? null : json["value"],
        status: json["status"] == null ? null : json["status"],
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
      );
}
