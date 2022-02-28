import 'dart:convert';

RemarkModel remarkModelFromJson(dynamic str) => RemarkModel.fromMap(str);

String remarkModelToJson(RemarkModel data) => json.encode(data.toMap());

class RemarkModel {
  RemarkModel({
    this.product,
  });

  final List<Product> product;

  factory RemarkModel.fromMap(Map<String, dynamic> json) => RemarkModel(
        product: json["product"] == null
            ? null
            : List<Product>.from(
                json["product"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "product": product == null
            ? null
            : List<dynamic>.from(product.map((x) => x.toMap())),
      };
}

class Product {
  Product({
    this.remark,
    this.numberOfProducts,
    this.remarkLevelSalesPercentage,
    this.bins,
  });

  final String remark;
  final int numberOfProducts;
  final String remarkLevelSalesPercentage;
  final List<Bin> bins;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        remark: json["remark"] == null ? null : json["remark"],
        numberOfProducts: json["number_of_products"] == null
            ? null
            : json["number_of_products"],
        remarkLevelSalesPercentage:
            json["remark_level_sales_percentage"] == null
                ? null
                : json["remark_level_sales_percentage"],
        bins: json["bins"] == null
            ? null
            : List<Bin>.from(json["bins"].map((x) => Bin.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "remark": remark == null ? null : remark,
        "number_of_products":
            numberOfProducts == null ? null : numberOfProducts,
        "remark_level_sales_percentage": remarkLevelSalesPercentage == null
            ? null
            : remarkLevelSalesPercentage,
        "bins": bins == null
            ? null
            : List<dynamic>.from(bins.map((x) => x.toMap())),
      };
}

class Bin {
  Bin({
    this.bin,
    this.numberOfBinProducts,
    this.binLevelSalesPercentage,
  });

  final String bin;
  final int numberOfBinProducts;
  final String binLevelSalesPercentage;

  factory Bin.fromMap(Map<String, dynamic> json) => Bin(
        bin: json["bin"] == null ? null : json["bin"],
        numberOfBinProducts: json["number_of_bin_products"] == null
            ? null
            : json["number_of_bin_products"],
        binLevelSalesPercentage: json["bin_level_sales_percentage"] == null
            ? null
            : json["bin_level_sales_percentage"],
      );

  Map<String, dynamic> toMap() => {
        "bin": bin == null ? null : bin,
        "number_of_bin_products":
            numberOfBinProducts == null ? null : numberOfBinProducts,
        "bin_level_sales_percentage":
            binLevelSalesPercentage == null ? null : binLevelSalesPercentage,
      };
}
