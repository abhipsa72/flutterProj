// To parse this JSON data, do
//
//     final barChartResponse = barChartResponseFromJson(jsonString);

import 'dart:convert';

BarChartResponse barChartResponseFromJson(dynamic str) =>
    BarChartResponse.fromMap(str);

String barChartResponseToJson(BarChartResponse data) =>
    json.encode(data.toMap());

class BarChartResponse {
  BarChartData currentData;
  BarChartData yearBackData;

  BarChartResponse({
    this.currentData,
    this.yearBackData,
  });

  factory BarChartResponse.fromMap(Map<String, dynamic> json) =>
      BarChartResponse(
        currentData: json["current_Data"] == null
            ? null
            : BarChartData.fromMap(json["current_Data"]),
        yearBackData: json["yearBack_Data"] == null
            ? null
            : BarChartData.fromMap(json["yearBack_Data"]),
      );

  Map<String, dynamic> toMap() => {
        "current_Data": currentData == null ? null : currentData.toMap(),
        "yearBack_Data": yearBackData == null ? null : yearBackData.toMap(),
      };
}

class BarChartData {
  double fmcg;
  double oaf;
  double ff;
  double eaa;
  double llh;
  double fal;
  double cs;
  double ss;
  double gift;
  double ae;
  double ad;
  double rtas;

  BarChartData({
    this.fmcg,
    this.oaf,
    this.ff,
    this.eaa,
    this.llh,
    this.fal,
    this.cs,
    this.ss,
    this.gift,
    this.ae,
    this.ad,
    this.rtas,
  });

  factory BarChartData.fromMap(Map<String, dynamic> json) => BarChartData(
        fmcg: json["fmcg"] == null ? null : json["fmcg"].toDouble(),
        oaf: json["oaf"] == null ? null : json["oaf"].toDouble(),
        ff: json["ff"] == null ? null : json["ff"].toDouble(),
        eaa: json["eaa"] == null ? null : json["eaa"].toDouble(),
        llh: json["llh"] == null ? null : json["llh"].toDouble(),
        fal: json["fal"] == null ? null : json["fal"].toDouble(),
        cs: json["cs"] == null ? null : json["cs"].toDouble(),
        ss: json["ss"] == null ? null : json["ss"].toDouble(),
        gift: json["gift"] == null ? null : json["gift"].toDouble(),
        ae: json["ae"] == null ? null : json["ae"].toDouble(),
        ad: json["ad"] == null ? null : json["ad"].toDouble(),
        rtas: json["rtas"] == null ? null : json["rtas"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "fmcg": fmcg == null ? null : fmcg,
        "oaf": oaf == null ? null : oaf,
        "ff": ff == null ? null : ff,
        "eaa": eaa == null ? null : eaa,
        "llh": llh == null ? null : llh,
        "fal": fal == null ? null : fal,
        "cs": cs == null ? null : cs,
        "ss": ss == null ? null : ss,
        "gift": gift == null ? null : gift,
        "ae": ae == null ? null : ae,
        "ad": ad == null ? null : ad,
        "rtas": rtas == null ? null : rtas,
      };
}

class BarChartProduct {
  String type;
  String product;
  num quantity;

  BarChartProduct(this.product, this.type, this.quantity);
}
