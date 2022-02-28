// To parse this JSON data, do
//
//     final salesImpactChart = salesImpactChartFromJson(jsonString);

import 'dart:convert';

RoleDetails roleDetailsFromJson(dynamic str) => RoleDetails.fromMap(str);

String salesImpactChartToJson(RoleDetails data) => json.encode(data.toMap());

class RoleDetails {
  Role roleAnalytics;
  Role roleFinance;
  Role roleInwardManager;
  Role roleIt;
  Role rolePurchaser;
  Role roleStoreManager;
  Role roleWarehouseManager;

  RoleDetails({
    this.roleAnalytics,
    this.roleFinance,
    this.roleInwardManager,
    this.roleIt,
    this.rolePurchaser,
    this.roleStoreManager,
    this.roleWarehouseManager,
  });

  factory RoleDetails.fromMap(Map<String, dynamic> json) => RoleDetails(
        roleAnalytics: json["ROLE_ANALYTICS"] == null
            ? null
            : Role.fromMap(json["ROLE_ANALYTICS"]),
        roleFinance: json["ROLE_FINANACE"] == null
            ? null
            : Role.fromMap(json["ROLE_FINANACE"]),
        roleInwardManager: json["ROLE_INWARD_MANAGER"] == null
            ? null
            : Role.fromMap(json["ROLE_INWARD_MANAGER"]),
        roleIt: json["ROLE_IT"] == null ? null : Role.fromMap(json["ROLE_IT"]),
        rolePurchaser: json["ROLE_PURCHASER"] == null
            ? null
            : Role.fromMap(json["ROLE_PURCHASER"]),
        roleStoreManager: json["ROLE_STOREMANAGER"] == null
            ? null
            : Role.fromMap(json["ROLE_STOREMANAGER"]),
        roleWarehouseManager: json["ROLE_WAREHOUSE_MANAGER"] == null
            ? null
            : Role.fromMap(json["ROLE_WAREHOUSE_MANAGER"]),
      );

  Map<String, dynamic> toMap() => {
        "ROLE_ANALYTICS": roleAnalytics == null ? null : roleAnalytics.toMap(),
        "ROLE_FINANACE": roleFinance == null ? null : roleFinance.toMap(),
        "ROLE_INWARD_MANAGER":
            roleInwardManager == null ? null : roleInwardManager.toMap(),
        "ROLE_IT": roleIt == null ? null : roleIt.toMap(),
        "ROLE_PURCHASER": rolePurchaser == null ? null : rolePurchaser.toMap(),
        "ROLE_STOREMANAGER":
            roleStoreManager == null ? null : roleStoreManager.toMap(),
        "ROLE_WAREHOUSE_MANAGER":
            roleWarehouseManager == null ? null : roleWarehouseManager.toMap(),
      };
}

class Role {
  int comp;
  int wip;
  int ua;

  Role({
    this.comp,
    this.wip,
    this.ua,
  });

  factory Role.fromMap(Map<String, dynamic> json) => Role(
        comp: json["comp"] == null ? null : json["comp"],
        wip: json["wip"] == null ? null : json["wip"],
        ua: json["ua"] == null ? null : json["ua"],
      );

  Map<String, dynamic> toMap() => {
        "comp": comp == null ? null : comp,
        "wip": wip == null ? null : wip,
        "ua": ua == null ? null : ua,
      };
}

class RoleChart {
  String name;
  int value;

  RoleChart(this.name, this.value);
}
