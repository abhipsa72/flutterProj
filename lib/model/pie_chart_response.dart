import 'dart:convert';

import 'package:flutter/material.dart';

//PieChartResponse pieChartResponseFromJson(dynamic str) =>
//    PieChartResponse.fromMap(str);
//
//String pieChartResponseToJson(PieChartResponse data) =>
//    json.encode(data.toMap());

class PieChartResponse {
  final int lessVisibilityCompetitorOffersHrIssuesWeatherImpact;
  final int stockedOutYesterday;
  final int priceIncreasedFromPreviousWeeks;

  PieChartResponse({
    this.lessVisibilityCompetitorOffersHrIssuesWeatherImpact,
    this.stockedOutYesterday,
    this.priceIncreasedFromPreviousWeeks,
  });

  factory PieChartResponse.fromMap(Map<String, dynamic> json) =>
      PieChartResponse(
        lessVisibilityCompetitorOffersHrIssuesWeatherImpact: json["Less Visibility / Competitor Offers / HR Issues / Weather Impact"] == null
            ? 1
            :json["Less Visibility / Competitor Offers / HR Issues / Weather Impact"],
        stockedOutYesterday: json["Stocked out yesterday"] == null ? null : json["Stocked out yesterday"],
        priceIncreasedFromPreviousWeeks: json["Price increased from previous weeks"] == null ? null : json["Price increased from previous weeks"],
      );

  Map<String, dynamic> toMap() => {
    "Less Visibility / Competitor Offers / HR Issues / Weather Impact": lessVisibilityCompetitorOffersHrIssuesWeatherImpact == null ? 1 : lessVisibilityCompetitorOffersHrIssuesWeatherImpact,
    "Stocked out yesterday": stockedOutYesterday == null ? 1 : stockedOutYesterday,
    "Price increased from previous weeks": priceIncreasedFromPreviousWeeks == null ? 1 : priceIncreasedFromPreviousWeeks,
      };
}

class Task {
  String task;
  num taskValue;
  Color colorValue;

  Task(this.task, this.taskValue, this.colorValue);
}
