import 'dart:convert';

List<RepeatRefresh> repeatRefreshFromJson(List str) =>
    List<RepeatRefresh>.from(str.map((x) => RepeatRefresh.fromMap(x)));

String repeatRefreshToJson(List<RepeatRefresh> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class RepeatRefresh {
  RepeatRefresh({
    this.id,
    this.store,
    this.locCode,
    this.productCode,
    this.description,
    this.department,
    this.section,
    this.category,
    this.subCategory,
    this.count,
    this.storeCodes,
  });

  final String id;
  final String store;
  final int locCode;
  final int productCode;
  final String description;
  final String department;
  final String section;
  final String category;
  final String subCategory;

  final int count;
  final String storeCodes;

  factory RepeatRefresh.fromMap(Map<String, dynamic> json) => RepeatRefresh(
        id: json["id"] == null ? null : json["id"],
        store: json["store"] == null ? null : json["store"],
        locCode: json["loc_Code"] == null ? null : json["loc_Code"],
        productCode: json["product_Code"] == null ? null : json["product_Code"],
        description: json["description"] == null ? null : json["description"],
        department: json["department"] == null ? null : json["department"],
        section: json["section"] == null ? null : json["section"],
        category: json["category"] == null ? null : json["category"],
        subCategory: json["sub_Category"] == null ? null : json["sub_Category"],
        count: json["count"] == null ? null : json["count"],
        storeCodes: json["storeCodes"] == null ? null : json["storeCodes"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "store": store == null ? null : store,
        "loc_Code": locCode == null ? null : locCode,
        "product_Code": productCode == null ? null : productCode,
        "description": description == null ? null : description,
        "department": department == null ? null : department,
        "section": section == null ? null : section,
        "category": category == null ? null : category,
        "sub_Category": subCategory == null ? null : subCategory,
        "count": count == null ? null : count,
        "storeCodes": storeCodes == null ? null : storeCodes,
      };
}

enum AutoLpo { NO }

final autoLpoValues = EnumValues({"No": AutoLpo.NO});

enum Department { FMCG, FRESH_FOOD, LIGHT_HOUSE_HOLD }

final departmentValues = EnumValues({
  "FMCG": Department.FMCG,
  "FRESH FOOD": Department.FRESH_FOOD,
  "LIGHT HOUSE HOLD": Department.LIGHT_HOUSE_HOLD
});

enum ProbableReasons {
  LESS_VISIBILITY_COMPETITOR_OFFERS_HR_ISSUES_WEATHER_IMPACT,
  PRICE_INCREASED_FROM_PREVIOUS_WEEKS,
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

enum Region { KUWAIT }

final regionValues = EnumValues({"Kuwait": Region.KUWAIT});

enum Store { GRAND_HYPER_HASAWI }

final storeValues =
    EnumValues({"GRAND HYPER HASAWI": Store.GRAND_HYPER_HASAWI});

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
