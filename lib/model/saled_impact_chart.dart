// To parse this JSON data, do
//
//     final salesImpactChart = salesImpactChartFromJson(jsonString);

import 'dart:convert';

SalesImpact salesImpactChartFromJson(dynamic str) =>
    SalesImpact.fromMap(str);

String salesImpactChartToJson(SalesImpact data) =>
    json.encode(data.toMap());

class SalesImpact {
  double lessVisibility;
  double priceIncreased;
  double stockedOutYesterday;

  SalesImpact({
    this.lessVisibility,
    this.priceIncreased,
    this.stockedOutYesterday,
  });

  factory SalesImpact.fromMap(Map<String, dynamic> json) =>
      SalesImpact(
        lessVisibility: json[
                    "Less Visibility / Competitor Offers / HR Issues / Weather Impact"] ==
                null
            ? null
            : json[
                "Less Visibility / Competitor Offers / HR Issues / Weather Impact"],
        priceIncreased:
            json["Price increased from previous weeks"] == null
                ? null
                : json["Price increased from previous weeks"],
        stockedOutYesterday: json["Stocked out yesterday"] == null
            ? null
            : json["Stocked out yesterday"],
      );

  Map<String, dynamic> toMap() => {
        "Less Visibility / Competitor Offers / HR Issues / Weather Impact":
            lessVisibility == null
                ? null
                : lessVisibility,
        "Price increased from previous weeks":
            priceIncreased == null
                ? null
                : priceIncreased,
        "Stocked out yesterday":
            stockedOutYesterday == null ? null : stockedOutYesterday,
      };
}

class Sale {
  String name;
  double value;

  Sale(this.name, this.value);
}
