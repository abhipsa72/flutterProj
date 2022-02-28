// To parse this JSON data, do
//
//     final bubbleChartResponse = bubbleChartResponseFromJson(jsonString);

import 'dart:convert';

BubbleChartResponse bubbleChartResponseFromJson(dynamic str) =>
    BubbleChartResponse.fromMap(str);

String bubbleChartResponseToJson(BubbleChartResponse data) =>
    json.encode(data.toMap());

class BubbleChartResponse {
  int totalLoss;
  List<int> fmcgCountData;
  List<int> fmcgLosses;
  List<int> oafCountData;
  List<int> oafLosses;
  List<int> ffCountData;
  List<int> ffLosses;
  List<int> eaaCountData;
  List<int> eaaLosses;
  List<int> lhhCountData;
  List<int> lhhLosses;
  List<int> falCountData;
  List<int> falLosses;
//  List<int> csCountData;
//  List<int> csLosses;
//  List<int> ssCountData;
//  List<int> ssLosses;
//  List<int> giftsCountData;
//  List<int> giftsLosses;
//  List<int> aeCountData;
//  List<int> aeLosses;
//  List<int> adCountData;
//  List<int> adLosses;
//  List<int> rtasCountData;
//  List<int> rtasLosses;

  BubbleChartResponse({
    this.totalLoss,
    this.fmcgCountData,
    this.fmcgLosses,
    this.oafCountData,
    this.oafLosses,
    this.ffCountData,
    this.ffLosses,
    this.eaaCountData,
    this.eaaLosses,
    this.lhhCountData,
    this.lhhLosses,
    this.falCountData,
    this.falLosses,
//    this.csCountData,
//    this.csLosses,
//    this.ssCountData,
//    this.ssLosses,
//    this.giftsCountData,
//    this.giftsLosses,
//    this.aeCountData,
//    this.aeLosses,
//    this.adCountData,
//    this.adLosses,
//    this.rtasCountData,
 //   this.rtasLosses,
  });

  factory BubbleChartResponse.fromMap(Map<String, dynamic> json) =>
      BubbleChartResponse(
        totalLoss: json["total_Loss"] == null ? null : json["total_Loss"],
        fmcgCountData: json["fmcg_count_data"] == null
            ? null
            : List<int>.from(json["fmcg_count_data"].map((x) => x)),
        fmcgLosses: json["fmcg_losses"] == null
            ? null
            : List<int>.from(json["fmcg_losses"].map((x) => x)),
        oafCountData: json["oaf_count_data"] == null
            ? null
            : List<int>.from(json["oaf_count_data"].map((x) => x)),
        oafLosses: json["oaf_losses"] == null
            ? null
            : List<int>.from(json["oaf_losses"].map((x) => x)),
        ffCountData: json["ff_count_data"] == null
            ? null
            : List<int>.from(json["ff_count_data"].map((x) => x)),
        ffLosses: json["ff_losses"] == null
            ? null
            : List<int>.from(json["ff_losses"].map((x) => x)),
        eaaCountData: json["eaa_count_data"] == null
            ? null
            : List<int>.from(json["eaa_count_data"].map((x) => x)),
        eaaLosses: json["eaa_losses"] == null
            ? null
            : List<int>.from(json["eaa_losses"].map((x) => x)),
        lhhCountData: json["lhh_count_data"] == null
            ? null
            : List<int>.from(json["lhh_count_data"].map((x) => x)),
        lhhLosses: json["lhh_losses"] == null
            ? null
            : List<int>.from(json["lhh_losses"].map((x) => x)),
        falCountData: json["fal_count_data"] == null
            ? null
            : List<int>.from(json["fal_count_data"].map((x) => x)),
        falLosses: json["fal_losses"] == null
            ? null
            : List<int>.from(json["fal_losses"].map((x) => x)),
//        csCountData: json["cs_count_data"] == null
//            ? null
//            : List<int>.from(json["cs_count_data"].map((x) => x)),
//        csLosses: json["cs_losses"] == null
//            ? null
//            : List<int>.from(json["cs_losses"].map((x) => x)),
//        ssCountData: json["ss_count_data"] == null
//            ? null
//            : List<int>.from(json["ss_count_data"].map((x) => x)),
//        ssLosses: json["ss_losses"] == null
//            ? null
//            : List<int>.from(json["ss_losses"].map((x) => x)),
//        giftsCountData: json["gifts_count_data"] == null
//            ? null
//            : List<int>.from(json["gifts_count_data"].map((x) => x)),
//        giftsLosses: json["gifts_losses"] == null
//            ? null
//            : List<int>.from(json["gifts_losses"].map((x) => x)),
//        aeCountData: json["ae_count_data"] == null
//            ? null
//            : List<int>.from(json["ae_count_data"].map((x) => x)),
//        aeLosses: json["ae_losses"] == null
//            ? null
//            : List<int>.from(json["ae_losses"].map((x) => x)),
//        adCountData: json["ad_count_data"] == null
//            ? null
//            : List<int>.from(json["ad_count_data"].map((x) => x)),
//        adLosses: json["ad_losses"] == null
//            ? null
//            : List<int>.from(json["ad_losses"].map((x) => x)),
//        rtasCountData: json["rtas_count_data"] == null
//            ? null
//            : List<int>.from(json["rtas_count_data"].map((x) => x)),
//        rtasLosses: json["rtas_losses"] == null
//            ? null
//            : List<int>.from(json["rtas_losses"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "total_Loss": totalLoss == null ? null : totalLoss,
        "fmcg_count_data": fmcgCountData == null
            ? null
            : List<dynamic>.from(fmcgCountData.map((x) => x)),
        "fmcg_losses": fmcgLosses == null
            ? null
            : List<dynamic>.from(fmcgLosses.map((x) => x)),
        "oaf_count_data": oafCountData == null
            ? null
            : List<dynamic>.from(oafCountData.map((x) => x)),
        "oaf_losses": oafLosses == null
            ? null
            : List<dynamic>.from(oafLosses.map((x) => x)),
        "ff_count_data": ffCountData == null
            ? null
            : List<dynamic>.from(ffCountData.map((x) => x)),
        "ff_losses": ffLosses == null
            ? null
            : List<dynamic>.from(ffLosses.map((x) => x)),
        "eaa_count_data": eaaCountData == null
            ? null
            : List<dynamic>.from(eaaCountData.map((x) => x)),
        "eaa_losses": eaaLosses == null
            ? null
            : List<dynamic>.from(eaaLosses.map((x) => x)),
        "lhh_count_data": lhhCountData == null
            ? null
            : List<dynamic>.from(lhhCountData.map((x) => x)),
        "lhh_losses": lhhLosses == null
            ? null
            : List<dynamic>.from(lhhLosses.map((x) => x)),
        "fal_count_data": falCountData == null
            ? null
            : List<dynamic>.from(falCountData.map((x) => x)),
        "fal_losses": falLosses == null
            ? null
            : List<dynamic>.from(falLosses.map((x) => x)),
//        "cs_count_data": csCountData == null
//            ? null
//            : List<dynamic>.from(csCountData.map((x) => x)),
//        "cs_losses": csLosses == null
//            ? null
//            : List<dynamic>.from(csLosses.map((x) => x)),
//        "ss_count_data": ssCountData == null
//            ? null
//            : List<dynamic>.from(ssCountData.map((x) => x)),
//        "ss_losses": ssLosses == null
//            ? null
//            : List<dynamic>.from(ssLosses.map((x) => x)),
//        "gifts_count_data": giftsCountData == null
//            ? null
//            : List<dynamic>.from(giftsCountData.map((x) => x)),
//        "gifts_losses": giftsLosses == null
//            ? null
//            : List<dynamic>.from(giftsLosses.map((x) => x)),
//        "ae_count_data": aeCountData == null
//            ? null
//            : List<dynamic>.from(aeCountData.map((x) => x)),
//        "ae_losses": aeLosses == null
//            ? null
//            : List<dynamic>.from(aeLosses.map((x) => x)),
//        "ad_count_data": adCountData == null
//            ? null
//            : List<dynamic>.from(adCountData.map((x) => x)),
//        "ad_losses": adLosses == null
//            ? null
//            : List<dynamic>.from(adLosses.map((x) => x)),
//        "rtas_count_data": rtasCountData == null
//            ? null
//            : List<dynamic>.from(rtasCountData.map((x) => x)),
//        "rtas_losses": rtasLosses == null
//            ? null
//            : List<dynamic>.from(rtasLosses.map((x) => x)),
      };
}

class LinearSales {
  final int year;
  final int sales;
  final int radius;

  LinearSales(this.year, this.sales, this.radius);
}
