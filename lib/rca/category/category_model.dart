import 'dart:convert';

CategoryModel categoryModelFromJson(dynamic str) => CategoryModel.fromMap(str);

String categoryModelToJson(CategoryModel data) => json.encode(data.toMap());

class CategoryModel {
  CategoryModel({
    this.category,
  });

  final List<Category> category;

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        category: json["category"] == null
            ? null
            : List<Category>.from(
                json["category"].map((x) => Category.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "category": category == null
            ? null
            : List<dynamic>.from(category.map((x) => x.toMap())),
      };
}

class Category {
  Category({
    this.categoryCode,
    this.categoryVariationPercentage,
    this.losses,
    this.category,
    this.categoryVariation,
    this.sales,
    this.lossesPercentage,
    this.budget,
  });

  final String categoryCode;
  final dynamic categoryVariationPercentage;
  final int losses;
  final String category;
  final int categoryVariation;
  final int sales;
  final dynamic lossesPercentage;
  final int budget;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        categoryCode:
            json["category_code"] == null ? null : json["category_code"],
        categoryVariationPercentage:
            json["category_variation_percentage"] == null
                ? null
                : json["category_variation_percentage"],
        losses: json["losses"] == null ? null : json["losses"],
        category: json["category"] == null ? null : json["category"],
        categoryVariation: json["category_variation"] == null
            ? null
            : json["category_variation"],
        sales: json["sales"] == null ? null : json["sales"],
        lossesPercentage: json["losses_percentage"] == null
            ? null
            : json["losses_percentage"],
        budget: json["budget"] == null ? null : json["budget"],
      );

  Map<String, dynamic> toMap() => {
        "category_code": categoryCode == null ? null : categoryCode,
        "category_variation_percentage": categoryVariationPercentage == null
            ? null
            : categoryVariationPercentage,
        "losses": losses == null ? null : losses,
        "category": category == null ? null : category,
        "category_variation":
            categoryVariation == null ? null : categoryVariation,
        "sales": sales == null ? null : sales,
        "losses_percentage": lossesPercentage == null ? null : lossesPercentage,
        "budget": budget == null ? null : budget,
      };
}
