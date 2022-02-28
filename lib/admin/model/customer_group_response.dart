import 'dart:convert';

CustomerGroupResponse customerGroupFromMap(dynamic str) =>
    CustomerGroupResponse.fromMap(str);

String customerGroupResponseToMap(CustomerGroupResponse data) =>
    json.encode(data.toMap());

class CustomerGroupResponse {
  CustomerGroupResponse({
    this.success,
  });

  Success success;

  factory CustomerGroupResponse.fromMap(Map<String, dynamic> json) =>
      CustomerGroupResponse(
        success:
            json["success"] == null ? null : Success.fromMap(json["success"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success.toMap(),
      };
}

class Success {
  Success({
    this.customerGroups,
  });

  List<CustomerGroup> customerGroups;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        customerGroups: json["customer_groups"] == null
            ? null
            : List<CustomerGroup>.from(
                json["customer_groups"].map((x) => CustomerGroup.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "customer_groups": customerGroups == null
            ? null
            : List<dynamic>.from(customerGroups.map((x) => x.toMap())),
      };
}

class CustomerGroup {
  CustomerGroup({
    this.customerGroupId,
    this.approval,
    this.sortOrder,
    this.languageId,
    this.name,
    this.description,
  });

  String customerGroupId;
  String approval;
  String sortOrder;
  String languageId;
  String name;
  String description;

  factory CustomerGroup.fromMap(Map<String, dynamic> json) => CustomerGroup(
        customerGroupId: json["customer_group_id"] == null
            ? null
            : json["customer_group_id"],
        approval: json["approval"] == null ? null : json["approval"],
        sortOrder: json["sort_order"] == null ? null : json["sort_order"],
        languageId: json["language_id"] == null ? null : json["language_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toMap() => {
        "customer_group_id": customerGroupId == null ? null : customerGroupId,
        "approval": approval == null ? null : approval,
        "sort_order": sortOrder == null ? null : sortOrder,
        "language_id": languageId == null ? null : languageId,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
      };
}
