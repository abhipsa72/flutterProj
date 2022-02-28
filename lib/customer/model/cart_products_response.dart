import 'package:grand_uae/customer/enums/enum_values.dart';
import 'package:grand_uae/customer/enums/stock_status.dart';
import 'package:grand_uae/customer/model/product.dart';

ProductsResponse productFromJson(dynamic str) => ProductsResponse.fromJson(str);

class ProductsResponse {
  ProductsResponse({
    this.success,
  });

  Success success;

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      ProductsResponse(
        success: json["success"] == null
            ? null
            : Success.fromJson(
                json["success"],
              ),
      );
}

class Success {
  Success({
    this.products,
    this.totalProducts,
  });

  String totalProducts;
  List<Product> products;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        totalProducts:
            json['total_products'] == null ? "0" : json['total_products'],
        products: json["products"] == null
            ? []
            : List<Product>.from(json["products"].map(
                (x) => Product.fromMap(x),
              )),
      );
}

final stockStatusValues = EnumValues({
  "In Stock": StockStatus.IN_STOCK,
  "Out of Stock": StockStatus.OUT_OF_STOCK,
});
