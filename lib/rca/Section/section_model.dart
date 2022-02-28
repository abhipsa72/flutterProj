import 'dart:convert';

SectionModel sectionModelFromJson(dynamic str) => SectionModel.fromMap(str);

String sectionModelToJson(SectionModel data) => json.encode(data.toMap());

class SectionModel {
  SectionModel({
    this.section,
  });

  final List<Section> section;

  factory SectionModel.fromMap(Map<String, dynamic> json) => SectionModel(
        section: json["section"] == null
            ? null
            : List<Section>.from(
                json["section"].map((x) => Section.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "section": section == null
            ? null
            : List<dynamic>.from(section.map((x) => x.toMap())),
      };
}

class Section {
  Section({
    this.sectionVariationPercentage,
    this.sectionVariation,
    this.sectionCode,
    this.section,
    this.losses,
    this.sales,
    this.lossesPercentage,
    this.budget,
  });

  final dynamic sectionVariationPercentage;
  final int sectionVariation;
  final String sectionCode;
  final String section;
  final int losses;
  final int sales;
  final dynamic lossesPercentage;
  final int budget;

  factory Section.fromMap(Map<String, dynamic> json) => Section(
        sectionVariationPercentage: json["section_variation_percentage"] == null
            ? null
            : json["section_variation_percentage"],
        sectionVariation: json["section_variation"] == null
            ? null
            : json["section_variation"],
        sectionCode: json["section_code"] == null ? null : json["section_code"],
        section: json["section"] == null ? null : json["section"],
        losses: json["losses"] == null ? null : json["losses"],
        sales: json["sales"] == null ? null : json["sales"],
        lossesPercentage: json["losses_percentage"] == null
            ? null
            : json["losses_percentage"],
        budget: json["budget"] == null ? null : json["budget"],
      );

  Map<String, dynamic> toMap() => {
        "section_variation_percentage": sectionVariationPercentage == null
            ? null
            : sectionVariationPercentage,
        "section_variation": sectionVariation == null ? null : sectionVariation,
        "section_code": sectionCode == null ? null : sectionCode,
        "section": section == null ? null : section,
        "losses": losses == null ? null : losses,
        "sales": sales == null ? null : sales,
        "losses_percentage": lossesPercentage == null ? null : lossesPercentage,
        "budget": budget == null ? null : budget,
      };
}
