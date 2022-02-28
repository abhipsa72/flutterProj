import 'dart:convert';

List<StoreProduct> storeProductsFromJson(List str) =>
    List<StoreProduct>.from(str.map((x) => StoreProduct.fromMap(x)));

String storeProductsToJson(List<StoreProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class StoreProduct {
  final String id;
  final String store;
  final int locCode;
  final int productCode;
  final String description;
  final Department department;
  final String section;
  final String category;
  final dynamic subCateg;
  final double d0Sales;
  final double d1Sales;
  final double d7Sales;
  final int avgSales;
  final int oEAvgSales;
  final int predSales;
  final int d0Trans;
  final int d1Trans;
  final int d7Trans;
  final int avgTrans;
  final int oEAvgTrans;
  final double d0Qty;
  final double d1Qty;
  final double d7Qty;
  final double avgQty;
  final double oEAvgQty;
  final double d0Price;
  final dynamic d1Price;
  final dynamic d7Price;
  final dynamic avgPrice;
  final double oEAvgPrice;
  final int d0Promo;
  final int d1Promo;
  final int d7Promo;
  final int oEAvgPromo;
  final int avgPromo;
  final double d0SgrpSales;
  final double d1SgrpSales;
  final double d7SgrpSales;
  final int avgSgrpSales;
  final int oEAvgSgrpSales;
  final String d0OpeningStock;
  final String warehouseStock;
  final String storeStock;
  final int rulesBroken;
  final AutoLpo autoLpo;
  final ProbableReasons probableReasons;
  final String suggestions;
  final String remarks;
  final DateTime createDate;
  final dynamic alarmId;
  final dynamic actionName;
  final dynamic actionId;
  final bool completed;
  final dynamic closingDate;
  final int timeTaken;
  final dynamic referedRole;
  final dynamic referedBy;
  final dynamic subActionName;
  final dynamic subActionId;
  final dynamic subActionRemarks;
  final dynamic barCode;
  final dynamic finalWorkflowPermission;
  final dynamic finalWorkflowId;
  final dynamic targetDays;
  final String supplier1Code;
  final String supplier2Code;
  final String supplier1Name;
  final String supplier2Name;
  final AssignedFrom assignedFrom;
  final dynamic assignedSupplier;
  final dynamic assignedSupplierId;
  final String region;
  final int count;
  final dynamic storeCodes;

  StoreProduct({
    this.id,
    this.store,
    this.locCode,
    this.productCode,
    this.description,
    this.department,
    this.section,
    this.category,
    this.subCateg,
    this.d0Sales,
    this.d1Sales,
    this.d7Sales,
    this.avgSales,
    this.oEAvgSales,
    this.predSales,
    this.d0Trans,
    this.d1Trans,
    this.d7Trans,
    this.avgTrans,
    this.oEAvgTrans,
    this.d0Qty,
    this.d1Qty,
    this.d7Qty,
    this.avgQty,
    this.oEAvgQty,
    this.d0Price,
    this.d1Price,
    this.d7Price,
    this.avgPrice,
    this.oEAvgPrice,
    this.d0Promo,
    this.d1Promo,
    this.d7Promo,
    this.oEAvgPromo,
    this.avgPromo,
    this.d0SgrpSales,
    this.d1SgrpSales,
    this.d7SgrpSales,
    this.avgSgrpSales,
    this.oEAvgSgrpSales,
    this.d0OpeningStock,
    this.warehouseStock,
    this.storeStock,
    this.rulesBroken,
    this.autoLpo,
    this.probableReasons,
    this.suggestions,
    this.remarks,
    this.createDate,
    this.alarmId,
    this.actionName,
    this.actionId,
    this.completed,
    this.closingDate,
    this.timeTaken,
    this.referedRole,
    this.referedBy,
    this.subActionName,
    this.subActionId,
    this.subActionRemarks,
    this.barCode,
    this.finalWorkflowPermission,
    this.finalWorkflowId,
    this.targetDays,
    this.supplier1Code,
    this.supplier2Code,
    this.supplier1Name,
    this.supplier2Name,
    this.assignedFrom,
    this.assignedSupplier,
    this.assignedSupplierId,
    this.region,
    this.count,
    this.storeCodes,
  });

  factory StoreProduct.fromMap(Map<String, dynamic> json) => StoreProduct(
        id: json["id"] == null ? null : json["id"],
        store: json["store"] == null ? "NA" : json["store"],
        locCode: json["loc_Code"] == null ? null : json["loc_Code"],
        productCode: json["product_Code"] == null ? null : json["product_Code"],
        description: json["description"] == null ? null : json["description"],
        department: json["department"] == null
            ? null
            : departmentValues.map[json["department"]],
        section: json["section"] == null ? null : json["section"],
        category: json["category"] == null ? null : json["category"],
        subCateg: json["sub_Categ"],
        d0Sales: json["d0_Sales"] == null ? null : json["d0_Sales"].toDouble(),
        d1Sales: json["d1_Sales"] == null ? null : json["d1_Sales"].toDouble(),
        d7Sales: json["d7_Sales"] == null ? null : json["d7_Sales"].toDouble(),
        avgSales: json["avg_Sales"] == null ? null : json["avg_Sales"],
        oEAvgSales: json["oE_Avg_Sales"] == null ? null : json["oE_Avg_Sales"],
        predSales: json["pred_Sales"] == null ? null : json["pred_Sales"],
        d0Trans: json["d0_Trans"] == null ? null : json["d0_Trans"],
        d1Trans: json["d1_Trans"] == null ? null : json["d1_Trans"],
        d7Trans: json["d7_Trans"] == null ? null : json["d7_Trans"],
        avgTrans: json["avg_Trans"] == null ? null : json["avg_Trans"],
        oEAvgTrans: json["oE_Avg_Trans"] == null ? null : json["oE_Avg_Trans"],
        d0Qty: json["d0_Qty"] == null ? null : json["d0_Qty"].toDouble(),
        d1Qty: json["d1_Qty"] == null ? null : json["d1_Qty"].toDouble(),
        d7Qty: json["d7_Qty"] == null ? null : json["d7_Qty"].toDouble(),
        avgQty: json["avg_Qty"] == null ? null : json["avg_Qty"].toDouble(),
        oEAvgQty:
            json["oE_Avg_Qty"] == null ? null : json["oE_Avg_Qty"].toDouble(),
        d0Price: json["d0_Price"] == null ? null : json["d0_Price"],
        d1Price: json["d1_price"],
        d7Price: json["d7_Price"] == null ? null : json["d7_Price"],
        avgPrice:
            json["avg_Price"] == null ? null : json["avg_Price"].toDouble(),
        oEAvgPrice: json["oE_Avg_Price"] == null
            ? null
            : json["oE_Avg_Price"].toDouble(),
        d0Promo: json["d0_Promo"] == null ? null : json["d0_Promo"],
        d1Promo: json["d1_Promo"] == null ? null : json["d1_Promo"],
        d7Promo: json["d7_Promo"] == null ? null : json["d7_Promo"],
        oEAvgPromo: json["oE_Avg_Promo"] == null ? null : json["oE_Avg_Promo"],
        avgPromo: json["avg_Promo"] == null ? null : json["avg_Promo"],
        d0SgrpSales: json["d0_Sgrp_Sales"] == null
            ? null
            : json["d0_Sgrp_Sales"].toDouble(),
        d1SgrpSales: json["d1_Sgrp_Sales"] == null
            ? null
            : json["d1_Sgrp_Sales"].toDouble(),
        d7SgrpSales: json["d7_Sgrp_Sales"] == null
            ? null
            : json["d7_Sgrp_Sales"].toDouble(),
        avgSgrpSales:
            json["avg_Sgrp_Sales"] == null ? null : json["avg_Sgrp_Sales"],
        oEAvgSgrpSales: json["oE_Avg_Sgrp_Sales"] == null
            ? null
            : json["oE_Avg_Sgrp_Sales"],
        d0OpeningStock:
            json["d0_Opening_Stock"] == null ? null : json["d0_Opening_Stock"],
        warehouseStock:
            json["warehouse_Stock"] == "NA" ? null : json["warehouse_Stock"],
        storeStock: json["store_Stock"] == "NA" ? null : json["store_Stock"],
        rulesBroken: json["rules_Broken"] == null ? null : json["rules_Broken"],
        autoLpo: json["auto_LPO"] == null
            ? null
            : autoLpoValues.map[json["auto_LPO"]],
        probableReasons: json["probable_Reasons"] == null
            ? null
            : probableReasonsValues.map[json["probable_Reasons"]],
        suggestions: json["suggestions"] == null ? null : json["suggestions"],
        remarks: json["remarks"] == null ? null : json["remarks"],
        createDate: json["create_Date"] == null
            ? null
            : DateTime.parse(json["create_Date"]),
        alarmId: json["alarm_Id"],
        actionName: json["action_Name"],
        actionId: json["action_Id"],
        completed: json["completed"] == null ? null : json["completed"],
        closingDate: json["closingDate"],
        timeTaken: json["timeTaken"] == null ? null : json["timeTaken"],
        referedRole: json["referedRole"],
        referedBy: json["referedBy"],
        subActionName: json["subActionName"],
        subActionId: json["subActionId"],
        subActionRemarks: json["subActionRemarks"],
        barCode: json["barCode"],
        finalWorkflowPermission: json["finalWorkflowPermission"],
        finalWorkflowId: json["finalWorkflowId"],
        targetDays: json["targetDays"],
        supplier1Code:
            json["supplier_1_Code"] == null ? null : json["supplier_1_Code"],
        supplier2Code:
            json["supplier_2_Code"] == null ? null : json["supplier_2_Code"],
        supplier1Name:
            json["supplier_1_Name"] == null ? null : json["supplier_1_Name"],
        supplier2Name:
            json["supplier_2_Name"] == null ? null : json["supplier_2_Name"],
        assignedFrom: json["assignedFrom"] == null
            ? null
            : AssignedFrom.fromMap(json["assignedFrom"]),
        assignedSupplier: json["assignedSupplier"],
        assignedSupplierId: json["assignedSupplierId"],
        region: json["region"] == null ? null : json["region"],
        count: json["count"] == null ? null : json["count"],
        storeCodes: json["storeCodes"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "store": store == null ? null : store,
        "loc_Code": locCode == null ? null : locCode,
        "product_Code": productCode == null ? null : productCode,
        "description": description == null ? null : description,
        "department":
            department == null ? null : departmentValues.reverse[department],
        "section": section == null ? null : section,
        "category": category == null ? null : category,
        "sub_Categ": subCateg,
        "d0_Sales": d0Sales == null ? null : d0Sales,
        "d1_Sales": d1Sales == null ? null : d1Sales,
        "d7_Sales": d7Sales == null ? null : d7Sales,
        "avg_Sales": avgSales == null ? null : avgSales,
        "oE_Avg_Sales": oEAvgSales == null ? null : oEAvgSales,
        "pred_Sales": predSales == null ? null : predSales,
        "d0_Trans": d0Trans == null ? null : d0Trans,
        "d1_Trans": d1Trans == null ? null : d1Trans,
        "d7_Trans": d7Trans == null ? null : d7Trans,
        "avg_Trans": avgTrans == null ? null : avgTrans,
        "oE_Avg_Trans": oEAvgTrans == null ? null : oEAvgTrans,
        "d0_Qty": d0Qty == null ? null : d0Qty,
        "d1_Qty": d1Qty == null ? null : d1Qty,
        "d7_Qty": d7Qty == null ? null : d7Qty,
        "avg_Qty": avgQty == null ? null : avgQty,
        "oE_Avg_Qty": oEAvgQty == null ? null : oEAvgQty,
        "d0_Price": d0Price == null ? null : d0Price,
        "d1_price": d1Price,
        "d7_Price": d7Price == null ? null : d7Price,
        "avg_Price": avgPrice == null ? null : avgPrice,
        "oE_Avg_Price": oEAvgPrice == null ? null : oEAvgPrice,
        "d0_Promo": d0Promo == null ? null : d0Promo,
        "d1_Promo": d1Promo == null ? null : d1Promo,
        "d7_Promo": d7Promo == null ? null : d7Promo,
        "oE_Avg_Promo": oEAvgPromo == null ? null : oEAvgPromo,
        "avg_Promo": avgPromo == null ? null : avgPromo,
        "d0_Sgrp_Sales": d0SgrpSales == null ? null : d0SgrpSales,
        "d1_Sgrp_Sales": d1SgrpSales == null ? null : d1SgrpSales,
        "d7_Sgrp_Sales": d7SgrpSales == null ? null : d7SgrpSales,
        "avg_Sgrp_Sales": avgSgrpSales == null ? null : avgSgrpSales,
        "oE_Avg_Sgrp_Sales": oEAvgSgrpSales == null ? null : oEAvgSgrpSales,
        "d0_Opening_Stock": d0OpeningStock == null ? null : d0OpeningStock,
        "warehouse_Stock": warehouseStock == null ? null : warehouseStock,
        "store_Stock": storeStock == null ? null : storeStock,
        "rules_Broken": rulesBroken == null ? null : rulesBroken,
        "auto_LPO": autoLpo == null ? null : autoLpoValues.reverse[autoLpo],
        "probable_Reasons": probableReasons == null
            ? null
            : probableReasonsValues.reverse[probableReasons],
        "suggestions": suggestions == null ? null : suggestions,
        "remarks": remarks == null ? null : remarks,
        "create_Date": createDate == null
            ? null
            : "${createDate.year.toString().padLeft(4, '0')}-${createDate.month.toString().padLeft(2, '0')}-${createDate.day.toString().padLeft(2, '0')}",
        "alarm_Id": alarmId,
        "action_Name": actionName,
        "action_Id": actionId,
        "completed": completed == null ? null : completed,
        "closingDate": closingDate,
        "timeTaken": timeTaken == null ? null : timeTaken,
        "referedRole": referedRole,
        "referedBy": referedBy,
        "subActionName": subActionName,
        "subActionId": subActionId,
        "subActionRemarks": subActionRemarks,
        "barCode": barCode,
        "finalWorkflowPermission": finalWorkflowPermission,
        "finalWorkflowId": finalWorkflowId,
        "targetDays": targetDays,
        "supplier_1_Code": supplier1Code == null ? null : supplier1Code,
        "supplier_2_Code": supplier2Code == null ? null : supplier2Code,
        "supplier_1_Name": supplier1Name == null ? null : supplier1Name,
        "supplier_2_Name": supplier2Name == null ? null : supplier2Name,
        "assignedFrom": assignedFrom,
        "assignedSupplier": assignedSupplier,
        "assignedSupplierId": assignedSupplierId,
        "region": region == null ? null : regionValues.reverse[region],
        "count": count == null ? null : count,
        "storeCodes": storeCodes,
      };
}

enum AutoLpo { NO }

final autoLpoValues = EnumValues({"No": AutoLpo.NO});

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

final departmentValues = EnumValues({
  "COMMUNICATION SERVICES": Department.COMMUNICATION_SERVICES,
  "ELECTRONICS  AND  APPLIANCES": Department.ELECTRONICS_AND_APPLIANCES,
  "FASHION  AND  LIFESTYLE": Department.FASHION_AND_LIFESTYLE,
  "FMCG": Department.FMCG,
  "FRESH FOOD": Department.FRESH_FOOD,
  "LIGHT HOUSE HOLD": Department.LIGHT_HOUSE_HOLD,
  "None": Department.NONE,
  "OPSS  AND  FROZEN": Department.OPSS_AND_FROZEN
});

class AssignedFrom {
  final String id;
  final String name;
  final String emailId;
  final String contactNumber;
  final String authToken;
  final String roles;
  final dynamic companyId;
  final dynamic regId;
  final dynamic storeName;
  final dynamic permissions;

  AssignedFrom({
    this.id,
    this.name,
    this.emailId,
    this.contactNumber,
    this.authToken,
    this.roles,
    this.companyId,
    this.regId,
    this.storeName,
    this.permissions,
  });

  factory AssignedFrom.fromMap(Map<String, dynamic> json) => AssignedFrom(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        emailId: json["emailId"] == null ? null : json["emailId"],
        contactNumber:
            json["contactNumber"] == null ? null : json["contactNumber"],
        authToken: json["authToken"] == null ? null : json["authToken"],
        roles: json["roles"] == null ? null : json["roles"],
        companyId: json["companyId"],
        //authTokenCreatedDate: json["authTokenCreatedDate"] == null ? null : AuthTokenCreatedDate.fromMap(json["authTokenCreatedDate"]),
        regId: json["regId"],
        storeName: json["storeName"],
        permissions: json["permissions"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "emailId": emailId == null ? null : emailId,
        "contactNumber": contactNumber == null ? null : contactNumber,
        "authToken": authToken == null ? null : authToken,
        "roles": roles == null ? null : roles,
        "companyId": companyId,
        "regId": regId,
        "storeName": storeName,
        "permissions": permissions,
      };
}

enum ProbableReasons {
  PRICE_INCREASED_FROM_PREVIOUS_WEEKS,
  LESS_VISIBILITY_COMPETITOR_OFFERS_HR_ISSUES_WEATHER_IMPACT,
  STOCKED_OUT_YESTERDAY
}

final probableReasonsValues = EnumValues({
  "Less Visibility / Competitor Offers / HR Issues / Weather Impact":
      ProbableReasons
          .LESS_VISIBILITY_COMPETITOR_OFFERS_HR_ISSUES_WEATHER_IMPACT,
  "Price increased from previous weeks":
      ProbableReasons.PRICE_INCREASED_FROM_PREVIOUS_WEEKS,
  "Stocked out yesterday": ProbableReasons.STOCKED_OUT_YESTERDAY
});

enum Region { DUBAI }

final regionValues = EnumValues({"Dubai": Region.DUBAI});

enum Store { GRAND_CITY_MALL }

final storeValues = EnumValues({"GRAND CITY MALL": Store.GRAND_CITY_MALL});

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
