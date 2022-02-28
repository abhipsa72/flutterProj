import 'dart:convert';

RegionModel regionModelFromJson(dynamic str) => RegionModel.fromMap(str);

String regionModelToJson(RegionModel data) => json.encode(data.toMap());

class RegionModel {
  RegionModel({
    this.regions,
  });

  final List<Region> regions;

  factory RegionModel.fromMap(Map<String, dynamic> json) => RegionModel(
        regions: json["regions"] == null
            ? null
            : List<Region>.from(json["regions"].map((x) => Region.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "regions": regions == null
            ? null
            : List<dynamic>.from(regions.map((x) => x.toMap())),
      };
}

class Region {
  Region(
      {this.budget,
      this.sales,
      this.variation,
      this.variationPercentage,
      this.loss,
      this.regionId,
      this.region,
      this.timePeriod});

  final int budget;
  final int sales;
  final dynamic variation;
  final int variationPercentage;
  final int loss;
  final String regionId;
  final String region;
  final String timePeriod;

  factory Region.fromMap(Map<String, dynamic> json) => Region(
        budget: json["budget"] == null ? null : json["budget"],
        sales: json["sales"] == null ? null : json["sales"],
        variation: json["variation"] == null ? null : json["variation"],
        variationPercentage: json["variation_percentage"] == null
            ? null
            : json["variation_percentage"],
        loss: json["loss"] == null ? null : json["loss"],
        regionId: json["region_id"] == null ? null : json["region_id"],
        region: json["region"] == null ? null : json["region"],
        timePeriod: json["timePeriod"] == null ? null : json["timePeriod"],
      );

  Map<String, dynamic> toMap() => {
        "budget": budget == null ? null : budget,
        "sales": sales == null ? null : sales,
        "variation": variation == null ? null : variation,
        "variation_percentage":
            variationPercentage == null ? null : variationPercentage,
        "loss": loss == null ? null : loss,
        "region_id": regionId == null ? null : regionId,
        "region": region == null ? null : region,
        "timePeriod": timePeriod == null ? null : timePeriod,
      };
}
