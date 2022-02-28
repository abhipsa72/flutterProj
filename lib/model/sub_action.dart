// To parse this JSON data, do
//
//     final subAction = subActionFromJson(jsonString);

import 'dart:convert';

List<SubAction> subActionFromJson(List list) =>
    List<SubAction>.from(list.map((x) => SubAction.fromMap(x)));

String subActionToJson(List<SubAction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SubAction {
  String id;
  String subActionName;
  int level;
  String actionName;
  String actionId;
  String attachedRole;

  SubAction({
    this.id,
    this.subActionName,
    this.level,
    this.actionName,
    this.actionId,
    this.attachedRole,
  });

  factory SubAction.fromMap(Map<String, dynamic> json) => SubAction(
        id: json["id"] == null ? null : json["id"],
        subActionName:
            json["subActionName"] == null ? null : json["subActionName"],
        level: json["level"] == null ? null : json["level"],
        actionName: json["actionName"] == null ? null : json["actionName"],
        actionId: json["actionId"] == null ? null : json["actionId"],
        attachedRole:
            json["attachedRole"] == null ? null : json["attachedRole"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "subActionName": subActionName == null ? null : subActionName,
        "level": level == null ? null : level,
        "actionName": actionName == null ? null : actionName,
        "actionId": actionId == null ? null : actionId,
        "attachedRole": attachedRole == null ? null : attachedRole,
      };
}
