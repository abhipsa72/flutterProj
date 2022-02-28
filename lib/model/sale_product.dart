// To parse this JSON data, do
//
//     final saleProduct = saleProductFromJson(jsonString);

import 'dart:convert';

List<SaleProduct> salesProductFromJson(List str) =>
    List<SaleProduct>.from(str.map((x) => SaleProduct.fromMap(x)));

String salesProductToJson(List<SaleProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SaleProduct {
  SaleProduct({
    this.productCode,
    this.product,
    this.subGroup,
    this.dept,
    this.frequency,
    this.stores,
  });

  final int productCode;
  final String product;
  final String subGroup;
  final Dept dept;
  final int frequency;
  final String stores;

  factory SaleProduct.fromMap(Map<String, dynamic> json) => SaleProduct(
        productCode: json["productCode"] == null ? null : json["productCode"],
        product: json["product"] == null ? null : json["product"],
        subGroup: json["subGroup"] == null ? null : json["subGroup"],
        dept: json["dept"] == null ? null : deptValues.map[json["dept"]],
        frequency: json["frequency"] == null ? null : json["frequency"],
        stores: json["stores"] == null ? null : json["stores"],
      );

  Map<String, dynamic> toMap() => {
        "productCode": productCode == null ? null : productCode,
        "product": product == null ? null : product,
        "subGroup": subGroup == null ? null : subGroup,
        "dept": dept == null ? null : deptValues.reverse[dept],
        "frequency": frequency == null ? null : frequency,
        "stores": stores == null ? null : stores,
      };
}

enum Dept {
  FRESH_FOOD,
  FMCG,
  LIGHT_HOUSE_HOLD,
  OPSS_AND_FROZEN,
  COMMUNICATION_SERVICES,
  FASHION_AND_LIFESTYLE,
  ELECTRONICS_AND_APPLIANCES
}

final deptValues = EnumValues({
  "COMMUNICATION SERVICES": Dept.COMMUNICATION_SERVICES,
  "ELECTRONICS  AND  APPLIANCES": Dept.ELECTRONICS_AND_APPLIANCES,
  "FASHION  AND  LIFESTYLE": Dept.FASHION_AND_LIFESTYLE,
  "FMCG": Dept.FMCG,
  "FRESH FOOD": Dept.FRESH_FOOD,
  "LIGHT HOUSE HOLD": Dept.LIGHT_HOUSE_HOLD,
  "OPSS  AND  FROZEN": Dept.OPSS_AND_FROZEN
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
