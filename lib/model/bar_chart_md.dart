import 'dart:convert';

DepartmentSales departmentSalesFromJson(dynamic str) =>
    DepartmentSales.fromMap(str);

String departmentSalesToJson(DepartmentSales data) => json.encode(data.toMap());

class DepartmentSales {
  DepartmentSales({
    this.currentData,
    this.yearBackData,
  });

  final Data currentData;
  final Data yearBackData;

  factory DepartmentSales.fromMap(Map<String, dynamic> json) => DepartmentSales(
        currentData: json["current_Data"] == null
            ? null
            : Data.fromMap(json["current_Data"]),
        yearBackData: json["yearBack_Data"] == null
            ? null
            : Data.fromMap(json["yearBack_Data"]),
      );

  Map<String, dynamic> toMap() => {
        "current_Data": currentData == null ? null : currentData.toMap(),
        "yearBack_Data": yearBackData == null ? null : yearBackData.toMap(),
      };
}

class Data {
  Data({
    this.fmcg,
    this.oaf,
    this.ff,
    this.eaa,
    this.llh,
    this.fal,
  });

  dynamic fmcg;
  dynamic oaf;
  dynamic ff;
  dynamic eaa;
  dynamic llh;
  dynamic fal;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        fmcg: json["fmcg"] == null ? null : json["fmcg"],
        oaf: json["oaf"] == null ? null : json["oaf"],
        ff: json["ff"] == null ? null : json["ff"],
        eaa: json["eaa"] == null ? null : json["eaa"],
        llh: json["llh"] == null ? null : json["llh"],
        fal: json["fal"] == null ? null : json["fal"],
      );

  Map<String, dynamic> toMap() => {
        "fmcg": fmcg == null ? null : fmcg,
        "oaf": oaf == null ? null : oaf,
        "ff": ff == null ? null : ff,
        "eaa": eaa == null ? null : eaa,
        "llh": llh == null ? null : llh,
        "fal": fal == null ? null : fal,
      };
}
