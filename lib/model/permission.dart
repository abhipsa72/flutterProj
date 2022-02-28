import 'dart:convert';

List<WarehouseAction> wareHouseActionFromJson(List str) =>
    List<WarehouseAction>.from(str.map((x) => WarehouseAction.fromMap(x)));

String wareHouseActionToJson(List<WarehouseAction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class WarehouseAction {
  final String id;
  final String role;
  final String permission;
  final String actions;
  final String forwardToRole;
  final int hasRole;
  final String permissionId;

  WarehouseAction({
    this.id,
    this.role,
    this.permission,
    this.actions,
    this.forwardToRole,
    this.hasRole,
    this.permissionId,
  });

  factory WarehouseAction.fromMap(Map<String, dynamic> json) => WarehouseAction(
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
