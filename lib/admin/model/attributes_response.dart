import 'dart:convert';

AttributesResponse attributesFromMap(dynamic str) =>
    AttributesResponse.fromMap(str);

String attributesResponseToMap(AttributesResponse data) =>
    json.encode(data.toMap());

class AttributesResponse {
  AttributesResponse({
    this.success,
  });

  Success success;

  factory AttributesResponse.fromMap(Map<String, dynamic> json) =>
      AttributesResponse(
        success:
            json["success"] == null ? null : Success.fromMap(json["success"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success.toMap(),
      };
}

class Success {
  Success({
    this.attributes,
  });

  List<Attribute> attributes;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        attributes: json["attributes"] == null
            ? null
            : List<Attribute>.from(
                json["attributes"].map((x) => Attribute.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes.map((x) => x.toMap())),
      };
}

class Attribute {
  Attribute({
    this.attributeId,
    this.attributeGroupId,
    this.sortOrder,
    this.languageId,
    this.name,
    this.attributeGroup,
  });

  String attributeId;
  String attributeGroupId;
  String sortOrder;
  String languageId;
  String name;
  AttributeGroup attributeGroup;

  factory Attribute.fromMap(Map<String, dynamic> json) => Attribute(
        attributeId: json["attribute_id"] == null ? null : json["attribute_id"],
        attributeGroupId: json["attribute_group_id"] == null
            ? null
            : json["attribute_group_id"],
        sortOrder: json["sort_order"] == null ? null : json["sort_order"],
        languageId: json["language_id"] == null ? null : json["language_id"],
        name: json["name"] == null ? null : json["name"],
        attributeGroup: json["attribute_group"] == null
            ? null
            : attributeGroupValues.map[json["attribute_group"]],
      );

  Map<String, dynamic> toMap() => {
        "attribute_id": attributeId == null ? null : attributeId,
        "attribute_group_id":
            attributeGroupId == null ? null : attributeGroupId,
        "sort_order": sortOrder == null ? null : sortOrder,
        "language_id": languageId == null ? null : languageId,
        "name": name == null ? null : name,
        "attribute_group": attributeGroup == null
            ? null
            : attributeGroupValues.reverse[attributeGroup],
      };
}

enum AttributeGroup { MEMORY, PROCESSOR }

final attributeGroupValues = EnumValues(
    {"Memory": AttributeGroup.MEMORY, "Processor": AttributeGroup.PROCESSOR});

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
