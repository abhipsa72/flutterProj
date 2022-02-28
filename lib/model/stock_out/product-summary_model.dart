// ProductSummary productSummaryFromJson(dynamic str) =>
//     ProductSummary.fromMap(str);
//
// String productSummaryToJson(ProductSummary data) => json.encode(data.toMap());
//
// class ProductSummary {
//   ProductSummary({
//     this.message,
//     this.stores,
//   });
//
//   final String message;
//   final List<StoreName> stores;
//
//   factory ProductSummary.fromMap(Map<String, dynamic> json) => ProductSummary(
//         message: json["message"] == null ? null : json["message"],
//         stores: json["stores"] == null
//             ? null
//             : List<StoreName>.from(
//                 json["stores"].map((x) => StoreName.fromMap(x))),
//       );
//
//   Map<String, dynamic> toMap() => {
//         "message": message == null ? null : message,
//         "stores": stores == null
//             ? null
//             : List<dynamic>.from(stores.map((x) => x.toMap())),
//       };
// }
//
// class StoreName {
//   StoreName({
//     this.store,
//     this.data,
//   });
//
//   final String store;
//   final Data data;
//
//   factory StoreName.fromMap(Map<String, dynamic> json) => StoreName(
//         store: json["store"] == null ? null : json["store"],
//         data: json["data"] == null ? null : Data.fromMap(json["data"]),
//       );
//
//   Map<String, dynamic> toMap() => {
//         "store": store == null ? null : store,
//         "data": data == null ? null : data.toMap(),
//       };
// }
//
// class Data {
//   Data({
//     this.flagDataYes,
//     this.flagDataNo,
//   });
//
//   final FlagData flagDataYes;
//   final FlagData flagDataNo;
//
//   factory Data.fromMap(Map<String, dynamic> json) => Data(
//         flagDataYes: json["flag_data_yes"] == null
//             ? null
//             : FlagData.fromMap(json["flag_data_yes"]),
//         flagDataNo: json["flag_data_no"] == null
//             ? null
//             : FlagData.fromMap(json["flag_data_no"]),
//       );
//
//   Map<String, dynamic> toMap() => {
//         "flag_data_yes": flagDataYes == null ? null : flagDataYes.toMap(),
//         "flag_data_no": flagDataNo == null ? null : flagDataNo.toMap(),
//       };
// }
//
// class FlagData {
//   FlagData({
//     this.flag,
//     this.noOfProducts,
//     this.noOfPendingPos,
//   });
//
//   final String flag;
//   final int noOfProducts;
//   final int noOfPendingPos;
//
//   factory FlagData.fromMap(Map<String, dynamic> json) => FlagData(
//         flag: json["flag"] == null ? null : json["flag"],
//         noOfProducts:
//             json["no_of_products"] == null ? null : json["no_of_products"],
//         noOfPendingPos: json["no_of_pending_pos"] == null
//             ? null
//             : json["no_of_pending_pos"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "flag": flag == null ? null : flag,
//         "no_of_products": noOfProducts == null ? null : noOfProducts,
//         "no_of_pending_pos": noOfPendingPos == null ? null : noOfPendingPos,
//       };
// }
//
// // enum Flag { NO, YES }
// //
// // final flagValues = EnumValues({"No": Flag.NO, "Yes": Flag.YES});
// //
// // class EnumValues<T> {
// //   Map<String, T> map;
// //   Map<T, String> reverseMap;
// //
// //   EnumValues(this.map);
// //
// //   Map<T, String> get reverse {
// //     if (reverseMap == null) {
// //       reverseMap = map.map((k, v) => new MapEntry(v, k));
// //     }
// //     return reverseMap;
// //   }
// // }
import 'dart:convert';

List<ProductSummary> productSummaryFromJson(List str) =>
    List<ProductSummary>.from(str.map((x) => ProductSummary.fromMap(x)));

String productSummaryToJson(List<ProductSummary> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ProductSummary {
  ProductSummary({
    this.id,
    this.slno,
    this.dt,
    this.region,
    this.store,
    this.dept,
    this.noofsku,
    this.oossku,
  });

  final String id;
  final String slno;
  final String dt;
  final String region;
  final String store;
  final String dept;
  final int noofsku;
  final int oossku;

  factory ProductSummary.fromMap(Map<String, dynamic> json) => ProductSummary(
        id: json["_id"] == null ? null : json["_id"],
        slno: json["slno"] == null ? null : json["slno"],
        dt: json["dt"] == null ? null : json["dt"],
        region: json["region"] == null ? null : json["region"],
        store: json["store"] == null ? null : json["store"],
        dept: json["dept"] == null ? null : json["dept"],
        noofsku: json["noofsku"] == null ? null : json["noofsku"],
        oossku: json["oossku"] == null ? null : json["oossku"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "slno": slno == null ? null : slno,
        "dt": dt == null ? null : dt,
        "region": region == null ? null : region,
        "store": store == null ? null : store,
        "dept": dept == null ? null : dept,
        "noofsku": noofsku == null ? null : noofsku,
        "oossku": oossku == null ? null : oossku,
      };
}
