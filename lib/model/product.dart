import 'dart:convert';

List<Product> productsFromJson(List str) =>
    List<Product>.from(str.map((x) => Product.fromMap(x)));

String productsToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Product {
  final String id;
  final String productId;
  final int productCode;
  final String currentRole;
  final String referedRole;
  final dynamic finalWorkflowPermission;
  final dynamic finalWorkflowId;
  final String remarks;
  final dynamic action;
  final DateTime date;
  final dynamic storeName;
  final int companyId;
  final Department department;
  final dynamic assignedSupplier;
  final String region;
  final String supplier1Name;
  final String supplier2Name;
  final String description;
  final String category;
  final String warehouseStock;
  final String storeStock;
  final int days;
  final bool currentReferStatus;
  final bool status;
  final String threadId;

  Product({
    this.id,
    this.productId,
    this.productCode,
    this.currentRole,
    this.referedRole,
    this.finalWorkflowPermission,
    this.finalWorkflowId,
    this.remarks,
    this.action,
    this.date,
    this.storeName,
    this.companyId,
    this.department,
    this.assignedSupplier,
    this.region,
    this.supplier1Name,
    this.supplier2Name,
    this.description,
    this.category,
    this.warehouseStock,
    this.storeStock,
    this.days,
    this.currentReferStatus,
    this.status,
    this.threadId,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        productId: json["productId"] == null ? null : json["productId"],
        productCode: json["productCode"] == null ? null : json["productCode"],
        currentRole: json["currentRole"] == null ? null : json["currentRole"],
        referedRole: json["referedRole"] == null ? null : json["referedRole"],
        finalWorkflowPermission: json["finalWorkflowPermission"],
        finalWorkflowId: json["finalWorkflowId"],
        remarks: json["remarks"] == null ? null : json["remarks"],
        action: json["action"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        storeName: json["storeName"] == null ? null : json["storeName"],
        companyId: json["companyId"] == null ? null : json["companyId"],
        department: json["department"] == null
            ? null
            : departmentValue.map[json["department"]],
        assignedSupplier: json["assignedSupplier"],
        region: json["region"] == null ? null : json["region"],
        supplier1Name:
            json["supplier_1_Name"] == null ? null : json["supplier_1_Name"],
        supplier2Name:
            json["supplier_2_Name"] == null ? null : json["supplier_2_Name"],
        description: json["description"] == null ? null : json["description"],
        category: json["category"] == null ? null : json["category"],
        warehouseStock:
            json["warehouseStock"] == null ? null : json["warehouseStock"],
        storeStock: json["storeStock"] == null ? null : json["storeStock"],
        days: json["days"] == null ? null : json["days"],
        currentReferStatus: json["currentReferStatus"] == null
            ? null
            : json["currentReferStatus"],
        status: json["status"] == null ? null : json["status"],
        threadId: json["threadId"] == null ? null : json["threadId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "productId": productId == null ? null : productId,
        "productCode": productCode == null ? null : productCode,
        "currentRole": currentRole == null ? null : currentRole,
        "referedRole": referedRole == null ? null : referedRole,
        "finalWorkflowPermission": finalWorkflowPermission,
        "finalWorkflowId": finalWorkflowId,
        "remarks": remarks == null ? null : remarks,
        "action": action,
        "date": date == null
            ? null
            : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "storeName": storeName == null ? null : storeName,
        "companyId": companyId == null ? null : companyId,
        "department": department == null ? null : department,
        "assignedSupplier": assignedSupplier,
        "region": region == null ? null : region,
        "supplier_1_Name": supplier1Name == null ? null : supplier1Name,
        "supplier_2_Name": supplier2Name == null ? null : supplier2Name,
        "description": description == null ? null : description,
        "category": category == null ? null : category,
        "warehouseStock": warehouseStock == null ? null : warehouseStock,
        "storeStock": storeStock == null ? null : storeStock,
        "days": days == null ? null : days,
        "currentReferStatus":
            currentReferStatus == null ? null : currentReferStatus,
        "status": status == null ? null : status,
        "threadId": threadId == null ? null : threadId,
      };
}

enum Department {
  NONE,
  FRESH_FOOD,
  OPSS_AND_FROZEN,
  FMCG,
  FASHION_AND_LIFESTYLE,
  COMMUNICATION_SERVICES,
  LIGHT_HOUSE_HOLD,
  ELECTRONICS_AND_APPLIANCES
}

final departmentValue = EnumValues({
  "COMMUNICATION SERVICES": Department.COMMUNICATION_SERVICES,
  "ELECTRONICS  AND  APPLIANCES": Department.ELECTRONICS_AND_APPLIANCES,
  "FASHION  AND  LIFESTYLE": Department.FASHION_AND_LIFESTYLE,
  "FMCG": Department.FMCG,
  "FRESH FOOD": Department.FRESH_FOOD,
  "LIGHT HOUSE HOLD": Department.LIGHT_HOUSE_HOLD,
  "None": Department.NONE,
  "OPSS  AND  FROZEN": Department.OPSS_AND_FROZEN
});

enum Region { DUBAI }

final regionValue = EnumValues({"Dubai": Region.DUBAI});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
