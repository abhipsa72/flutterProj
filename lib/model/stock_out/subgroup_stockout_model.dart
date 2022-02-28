import 'dart:convert';

SubGroup subGroupFromJson(dynamic str) => SubGroup.fromMap(str);

String subGroupToJson(SubGroup data) => json.encode(data.toMap());

class SubGroup {
  SubGroup({
    this.message,
    this.stores,
  });

  final String message;
  final List<Store> stores;

  factory SubGroup.fromMap(Map<String, dynamic> json) => SubGroup(
        message: json["message"] == null ? null : json["message"],
        stores: json["stores"] == null
            ? null
            : List<Store>.from(json["stores"].map((x) => Store.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "stores": stores == null
            ? null
            : List<dynamic>.from(stores.map((x) => x.toMap())),
      };
}

class Store {
  Store({
    this.store,
    this.subgroup,
  });

  final String store;
  final List<SubgroupElement> subgroup;

  factory Store.fromMap(Map<String, dynamic> json) => Store(
        store: json["store"] == null ? null : json["store"],
        subgroup: json["subgroup"] == null
            ? null
            : List<SubgroupElement>.from(
                json["subgroup"].map((x) => SubgroupElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "store": store == null ? null : store,
        "subgroup": subgroup == null
            ? null
            : List<dynamic>.from(subgroup.map((x) => x.toMap())),
      };
}

class SubgroupElement {
  SubgroupElement({
    this.subgroup,
    this.noOfSubgroup,
  });

  final String subgroup;
  final int noOfSubgroup;

  factory SubgroupElement.fromMap(Map<String, dynamic> json) => SubgroupElement(
        subgroup: json["subgroup"] == null ? null : json["subgroup"],
        noOfSubgroup:
            json["no_of_subgroup"] == null ? null : json["no_of_subgroup"],
      );

  Map<String, dynamic> toMap() => {
        "subgroup": subgroup == null ? null : subgroup,
        "no_of_subgroup": noOfSubgroup == null ? null : noOfSubgroup,
      };
}

// enum SubgroupEnum {
//   THE_50_PRODUCTS_STOCKED_OUT,
//   SUBGROUP_50_PRODUCTS_STOCKED_OUT
// }
//
// final subgroupEnumValues = EnumValues({
//   ">=50% products stocked out": SubgroupEnum.SUBGROUP_50_PRODUCTS_STOCKED_OUT,
//   "< 50% products stocked out": SubgroupEnum.THE_50_PRODUCTS_STOCKED_OUT
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
