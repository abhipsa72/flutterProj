// To parse this JSON data, do
//
//     final action = actionFromJson(jsonString);

import 'dart:convert';

List<AlarmAction> actionFromJson(List str) =>
    List<AlarmAction>.from(str.map((x) => AlarmAction.fromMap(x)));

String actionToJson(List<AlarmAction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class AlarmAction {
  String id;
  String alarmName;
  String action;
  String alarmId;
  int level;
  String attachedRole;

  AlarmAction({
    this.id,
    this.alarmName,
    this.action,
    this.alarmId,
    this.level,
    this.attachedRole,
  });

  factory AlarmAction.fromMap(Map<String, dynamic> json) => AlarmAction(
        id: json["id"] == null ? null : json["id"],
        alarmName: json["alarmName"] == null ? null : json["alarmName"],
        action: json["action"] == null ? null : json["action"],
        alarmId: json["alarmId"] == null ? null : json["alarmId"],
        level: json["level"] == null ? null : json["level"],
        attachedRole:
            json["attachedRole"] == null ? null : json["attachedRole"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "alarmName": alarmName == null ? null : alarmName,
        "action": action == null ? null : action,
        "alarmId": alarmId == null ? null : alarmId,
        "level": level == null ? null : level,
        "attachedRole": attachedRole == null ? null : attachedRole,
      };
}
