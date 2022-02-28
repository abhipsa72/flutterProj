// To parse this JSON data, do
//
//     final lineChartResponse = lineChartResponseFromJson(jsonString);

import 'dart:convert';

LineChartResponse lineChartResponseFromJson(dynamic str) =>
    LineChartResponse.fromMap(str);

String lineChartResponseToJson(LineChartResponse data) =>
    json.encode(data.toMap());

class LineChartResponse {
  List<LineChartData> currentData;
  List<LineChartData> yearBackData;

  LineChartResponse({
    this.currentData,
    this.yearBackData,
  });

  factory LineChartResponse.fromMap(Map<String, dynamic> json) =>
      LineChartResponse(
        currentData: json["current_data"] == null
            ? null
            : List<LineChartData>.from(
                json["current_data"].map((x) => LineChartData.fromMap(x))),
        yearBackData: json["yearback_data"] == null
            ? null
            : List<LineChartData>.from(
                json["yearback_data"].map((x) => LineChartData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "current_data": currentData == null
            ? null
            : List<dynamic>.from(currentData.map((x) => x.toMap())),
        "yearback_data": yearBackData == null
            ? null
            : List<dynamic>.from(yearBackData.map((x) => x.toMap())),
      };
}

class LineChartData {
  DateTime date;
  double sales;

  LineChartData({
    this.date,
    this.sales,
  });

  factory LineChartData.fromMap(Map<String, dynamic> json) => LineChartData(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        sales: json["sales"] == null ? null : json["sales"],
      );

  Map<String, dynamic> toMap() => {
        "date": date == null
            ? null
            : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "sales": sales == null ? null : sales,
      };
}

class Sales {
  DateTime day;
  double sales;

  Sales(this.day, this.sales);
}

class Week {
  int week;
  double value;

  Week(this.week, this.value);
}
