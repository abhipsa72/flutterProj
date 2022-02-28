import 'dart:convert';

List<WiProduct> wiProductFromJson(List str) => List<WiProduct>.from(str.map((x) => WiProduct.fromMap(x)));

String wiProductToJson(List<WiProduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class WiProduct {
  final String id;
  final String productId;
  final int productCode;
  final String currentRole;
  final String referedRole;
  final String finalWorkflowPermission;
  final String finalWorkflowId;
  final String remarks;
  final String action;
  final DateTime date;
  final String storeName;
  final int companyId;
  final String department;
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

  WiProduct({
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
  });

  factory WiProduct.fromMap(Map<String, dynamic> json) => WiProduct(
    id: json["id"] == null ? null : json["id"],
    productId: json["productId"] == null ? null : json["productId"],
    productCode: json["productCode"] == null ? null : json["productCode"],
    currentRole: json["currentRole"] == null ? null : json["currentRole"],
    referedRole: json["referedRole"] == null ? null : json["referedRole"],
    finalWorkflowPermission: json["finalWorkflowPermission"] == null ? null : json["finalWorkflowPermission"],
    finalWorkflowId: json["finalWorkflowId"] == null ? null : json["finalWorkflowId"],
    remarks: json["remarks"] == null ? null : json["remarks"],
    action: json["action"] == null ? null : json["action"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    storeName: json["storeName"] == null ? null : json["storeName"],
    companyId: json["companyId"] == null ? null : json["companyId"],
    department: json["department"] == null ? null : json["department"],
    assignedSupplier: json["assignedSupplier"],
    region: json["region"] == null ? null : json["region"],
    supplier1Name: json["supplier_1_Name"] == null ? null : json["supplier_1_Name"],
    supplier2Name: json["supplier_2_Name"] == null ? null : json["supplier_2_Name"],
    description: json["description"] == null ? null : json["description"],
    category: json["category"] == null ? null : json["category"],
    warehouseStock: json["warehouseStock"] == null ? null : json["warehouseStock"],
    storeStock: json["storeStock"] == null ? null : json["storeStock"],
    days: json["days"] == null ? null : json["days"],
    currentReferStatus: json["currentReferStatus"] == null ? null : json["currentReferStatus"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "productId": productId == null ? null : productId,
    "productCode": productCode == null ? null : productCode,
    "currentRole": currentRole == null ? null : currentRole,
    "referedRole": referedRole == null ? null : referedRole,
    "finalWorkflowPermission": finalWorkflowPermission == null ? null : finalWorkflowPermission,
    "finalWorkflowId": finalWorkflowId == null ? null : finalWorkflowId,
    "remarks": remarks == null ? null : remarks,
    "action": action == null ? null : action,
    "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
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
    "currentReferStatus": currentReferStatus == null ? null : currentReferStatus,
    "status": status == null ? null : status,
  };
}
