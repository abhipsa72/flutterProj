import 'dart:convert';

DepartmentModel departmentModelFromJson(dynamic str) =>
    DepartmentModel.fromMap(str);

String departmentModelToJson(DepartmentModel data) => json.encode(data.toMap());

class DepartmentModel {
  DepartmentModel({
    this.dept,
  });

  final List<Dept> dept;

  factory DepartmentModel.fromMap(Map<String, dynamic> json) => DepartmentModel(
        dept: json["dept"] == null
            ? null
            : List<Dept>.from(json["dept"].map((x) => Dept.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "dept": dept == null
            ? null
            : List<dynamic>.from(dept.map((x) => x.toMap())),
      };
}

class Dept {
  Dept({
    this.departmentVariation,
    this.departmentCode,
    this.departmentVariationPercentage,
    this.losses,
    this.department,
    this.sales,
    this.lossesPercentage,
    this.budget,
  });

  final int departmentVariation;
  final String departmentCode;
  final dynamic departmentVariationPercentage;
  final int losses;
  final String department;
  final int sales;
  final double lossesPercentage;
  final int budget;

  factory Dept.fromMap(Map<String, dynamic> json) => Dept(
        departmentVariation: json["department_variation"] == null
            ? null
            : json["department_variation"],
        departmentCode:
            json["department_code"] == null ? null : json["department_code"],
        departmentVariationPercentage:
            json["department_variation_percentage"] == null
                ? null
                : json["department_variation_percentage"],
        losses: json["losses"] == null ? null : json["losses"],
        department: json["department"] == null ? null : json["department"],
        sales: json["sales"] == null ? null : json["sales"],
        lossesPercentage: json["losses_percentage"] == null
            ? null
            : json["losses_percentage"].toDouble(),
        budget: json["budget"] == null ? null : json["budget"],
      );

  Map<String, dynamic> toMap() => {
        "department_variation":
            departmentVariation == null ? null : departmentVariation,
        "department_code": departmentCode == null ? null : departmentCode,
        "department_variation_percentage": departmentVariationPercentage == null
            ? null
            : departmentVariationPercentage,
        "losses": losses == null ? null : losses,
        "department": department == null ? null : department,
        "sales": sales == null ? null : sales,
        "losses_percentage": lossesPercentage == null ? null : lossesPercentage,
        "budget": budget == null ? null : budget,
      };
}
