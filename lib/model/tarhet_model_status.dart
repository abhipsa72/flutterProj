import 'dart:convert';

import 'package:zel_app/model/target_model.dart';

TargetListStatus targetListStatusFromJson(str) => TargetListStatus.fromMap(str);

String targetListStatusToJson(TargetListStatus data) =>
    json.encode(data.toMap());

class TargetListStatus {
  TargetListStatus({
    this.status,
    this.message,
    this.targetModel,
  });

  final bool status;
  final String message;
  final List<TargetModel> targetModel;

  factory TargetListStatus.fromMap(Map<String, dynamic> json) =>
      TargetListStatus(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        targetModel: json["targetModel"] == null
            ? null
            : List<TargetModel>.from(
                json["targetModel"].map((x) => TargetModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "targetModel": targetModel == null
            ? null
            : List<dynamic>.from(targetModel.map((x) => x.toMap())),
      };
}
