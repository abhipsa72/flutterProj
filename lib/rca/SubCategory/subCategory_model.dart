import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(dynamic str) =>
    SubCategoryModel.fromMap(str);

String subCategoryModelToJson(SubCategoryModel data) =>
    json.encode(data.toMap());

class SubCategoryModel {
  SubCategoryModel({
    this.subcategory,
  });

  final List<Subcategory> subcategory;

  factory SubCategoryModel.fromMap(Map<String, dynamic> json) =>
      SubCategoryModel(
        subcategory: json["subcategory"] == null
            ? null
            : List<Subcategory>.from(
                json["subcategory"].map((x) => Subcategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "subcategory": subcategory == null
            ? null
            : List<dynamic>.from(subcategory.map((x) => x.toMap())),
      };
}

class Subcategory {
  Subcategory({
    this.subcategoryVariation,
    this.losses,
    this.subcategoryVariationPercentage,
    this.subcategory,
    this.sales,
    this.lossesPercentage,
    this.subcategoryCode,
    this.budget,
  });

  final int subcategoryVariation;
  final int losses;
  final dynamic subcategoryVariationPercentage;
  final String subcategory;
  final int sales;
  final int lossesPercentage;
  final String subcategoryCode;
  final int budget;

  factory Subcategory.fromMap(Map<String, dynamic> json) => Subcategory(
        subcategoryVariation: json["subcategory_variation"] == null
            ? null
            : json["subcategory_variation"],
        losses: json["losses"] == null ? null : json["losses"],
        subcategoryVariationPercentage:
            json["subcategory_variation_percentage"] == null
                ? null
                : json["subcategory_variation_percentage"],
        subcategory: json["subcategory"] == null ? null : json["subcategory"],
        sales: json["sales"] == null ? null : json["sales"],
        lossesPercentage: json["losses_percentage"] == null
            ? null
            : json["losses_percentage"],
        subcategoryCode:
            json["subcategory_code"] == null ? null : json["subcategory_code"],
        budget: json["budget"] == null ? null : json["budget"],
      );

  Map<String, dynamic> toMap() => {
        "subcategory_variation":
            subcategoryVariation == null ? null : subcategoryVariation,
        "losses": losses == null ? null : losses,
        "subcategory_variation_percentage":
            subcategoryVariationPercentage == null
                ? null
                : subcategoryVariationPercentage,
        "subcategory": subcategory == null ? null : subcategory,
        "sales": sales == null ? null : sales,
        "losses_percentage": lossesPercentage == null ? null : lossesPercentage,
        "subcategory_code": subcategoryCode == null ? null : subcategoryCode,
        "budget": budget == null ? null : budget,
      };
}
