import 'dart:convert';

ManufactureResponse manufactureFromMap(dynamic str) =>
    ManufactureResponse.fromMap(str);

String manufactureResponseToMap(ManufactureResponse data) =>
    json.encode(data.toMap());

class ManufactureResponse {
  ManufactureResponse({
    this.success,
  });

  Success success;

  factory ManufactureResponse.fromMap(Map<String, dynamic> json) =>
      ManufactureResponse(
        success:
            json["success"] == null ? null : Success.fromMap(json["success"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success.toMap(),
      };
}

class Success {
  Success({
    this.manufacturers,
  });

  List<Manufacturer> manufacturers;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        manufacturers: json["manufacturers"] == null
            ? null
            : List<Manufacturer>.from(
                json["manufacturers"].map((x) => Manufacturer.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "manufacturers": manufacturers == null
            ? null
            : List<dynamic>.from(manufacturers.map((x) => x.toMap())),
      };
}

class Manufacturer {
  Manufacturer({
    this.manufacturerId,
    this.name,
    this.image,
    this.sortOrder,
  });

  String manufacturerId;
  String name;
  dynamic image;
  String sortOrder;

  factory Manufacturer.fromMap(Map<String, dynamic> json) => Manufacturer(
        manufacturerId:
            json["manufacturer_id"] == null ? null : json["manufacturer_id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"],
        sortOrder: json["sort_order"] == null ? null : json["sort_order"],
      );

  Map<String, dynamic> toMap() => {
        "manufacturer_id": manufacturerId == null ? null : manufacturerId,
        "name": name == null ? null : name,
        "image": image,
        "sort_order": sortOrder == null ? null : sortOrder,
      };
}
