// To parse this JSON data, do
//
//     final financeAction = financeActionFromJson(jsonString);

import 'dart:convert';

List<FinanceAction> financeActionFromJson(List str) =>
    List<FinanceAction>.from(str.map((x) => FinanceAction.fromMap(x)));

String financeActionToJson(List<FinanceAction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class FinanceAction {
  String id;
  String role;
  String permission;
  String actions;
  String forwardToRole;
  int hasRole;
  String permissionId;

  FinanceAction({
    this.id,
    this.role,
    this.permission,
    this.actions,
    this.forwardToRole,
    this.hasRole,
    this.permissionId,
  });

  factory FinanceAction.fromMap(Map<String, dynamic> json) => FinanceAction(
        id: json["id"] == null ? null : json["id"],
        role: json["role"] == null ? null : json["role"],
        permission: json["permission"] == null ? null : json["permission"],
        actions: json["actions"] == null ? null : json["actions"],
        forwardToRole:
            json["forward_To_Role"] == null ? null : json["forward_To_Role"],
        hasRole: json["has_Role"] == null ? null : json["has_Role"],
        permissionId:
            json["permissionId"] == null ? null : json["permissionId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "role": role == null ? null : role,
        "permission": permission == null ? null : permission,
        "actions": actions == null ? null : actions,
        "forward_To_Role": forwardToRole == null ? null : forwardToRole,
        "has_Role": hasRole == null ? null : hasRole,
        "permissionId": permissionId == null ? null : permissionId,
      };
}
