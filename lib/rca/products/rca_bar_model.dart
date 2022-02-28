import 'dart:convert';

RcaBar rcaBarFromJson(dynamic str) => RcaBar.fromMap(str);

String rcaBarToJson(RcaBar data) => json.encode(data.toMap());

class RcaBar {
  RcaBar({
    this.message,
    this.result,
  });

  final String message;
  final List<Result> result;

  factory RcaBar.fromMap(Map<String, dynamic> json) => RcaBar(
        message: json["message"] == null ? null : json["message"],
        result: json["result"] == null
            ? null
            : List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "result": result == null
            ? null
            : List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.bin,
    this.binLevelPercentage,
    this.countPercentage,
  });

  final String bin;
  final double binLevelPercentage;
  final dynamic countPercentage;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        bin: json["bin"] == null ? null : json["bin"],
        binLevelPercentage: json["bin_level_percentage"] == null
            ? null
            : json["bin_level_percentage"].toDouble(),
        countPercentage:
            json["count_percentage"] == null ? null : json["count_percentage"],
      );

  Map<String, dynamic> toMap() => {
        "bin": bin == null ? null : bin,
        "bin_level_percentage":
            binLevelPercentage == null ? null : binLevelPercentage,
        "count_percentage": countPercentage == null ? null : countPercentage,
      };
}
