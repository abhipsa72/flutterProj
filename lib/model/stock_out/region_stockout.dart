import 'dart:convert';

RegionStockout regionFromJson(dynamic str) => RegionStockout.fromMap(str);

String regionToMap(RegionStockout data) => json.encode(data.toMap());

class RegionStockout {
  RegionStockout({
    this.message,
    this.regions,
  });

  final String message;
  final List<String> regions;

  factory RegionStockout.fromMap(Map<String, dynamic> json) => RegionStockout(
        message: json["message"] == null ? null : json["message"],
        regions: json["regions"] == null
            ? null
            : List<String>.from(json["regions"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "regions":
            regions == null ? null : List<dynamic>.from(regions.map((x) => x)),
      };
}
