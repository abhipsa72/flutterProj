import 'dart:convert';

ProductsResponse adminProductsFromMap(dynamic str) =>
    ProductsResponse.fromMap(str);

String productsResponseToMap(ProductsResponse data) =>
    json.encode(data.toMap());

class ProductsResponse {
  ProductsResponse({
    this.success,
  });

  Success success;

  factory ProductsResponse.fromMap(Map<String, dynamic> json) =>
      ProductsResponse(
        success:
            json["success"] == null ? null : Success.fromMap(json["success"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success.toMap(),
      };
}

class Success {
  Success({
    this.products,
  });

  List<AdminProduct> products;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        products: json["products"] == null
            ? null
            : List<AdminProduct>.from(
                json["products"].map((x) => AdminProduct.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toMap())),
      };
}

class AdminProduct {
  AdminProduct({
    this.productId,
    this.model,
    this.sku,
    this.upc,
    this.ean,
    this.jan,
    this.isbn,
    this.mpn,
    this.location,
    this.quantity,
    this.stockStatusId,
    this.image,
    this.manufacturerId,
    this.shipping,
    this.price,
    this.points,
    this.taxClassId,
    this.dateAvailable,
    this.weight,
    this.weightClassId,
    this.length,
    this.width,
    this.height,
    this.lengthClassId,
    this.subtract,
    this.minimum,
    this.sortOrder,
    this.status,
    this.viewed,
    this.dateAdded,
    this.dateModified,
    this.languageId,
    this.name,
    this.description,
    this.tag,
    this.metaTitle,
    this.metaDescription,
    this.metaKeyword,
  });

  String productId;
  String model;
  String sku;
  String upc;
  String ean;
  String jan;
  String isbn;
  String mpn;
  String location;
  String quantity;
  String stockStatusId;
  String image;
  String manufacturerId;
  String shipping;
  String price;
  String points;
  String taxClassId;
  DateTime dateAvailable;
  String weight;
  String weightClassId;
  String length;
  String width;
  String height;
  String lengthClassId;
  String subtract;
  String minimum;
  String sortOrder;
  String status;
  String viewed;
  DateTime dateAdded;
  DateTime dateModified;
  String languageId;
  String name;
  String description;
  String tag;
  String metaTitle;
  String metaDescription;
  String metaKeyword;

  String priceString() {
    return double.parse(price).toStringAsFixed(2);
  }

  factory AdminProduct.fromMap(Map<String, dynamic> json) => AdminProduct(
        productId: json["product_id"] == null ? null : json["product_id"],
        model: json["model"] == null ? null : json["model"],
        sku: json["sku"] == null ? null : json["sku"],
        upc: json["upc"] == null ? null : json["upc"],
        ean: json["ean"] == null ? null : json["ean"],
        jan: json["jan"] == null ? null : json["jan"],
        isbn: json["isbn"] == null ? null : json["isbn"],
        mpn: json["mpn"] == null ? null : json["mpn"],
        location: json["location"] == null ? null : json["location"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        stockStatusId:
            json["stock_status_id"] == null ? null : json["stock_status_id"],
        image: json["image"] == null ? null : json["image"],
        manufacturerId:
            json["manufacturer_id"] == null ? null : json["manufacturer_id"],
        shipping: json["shipping"] == null ? null : json["shipping"],
        price: json["price"] == null ? null : json["price"],
        points: json["points"] == null ? null : json["points"],
        taxClassId: json["tax_class_id"] == null ? null : json["tax_class_id"],
        dateAvailable: json["date_available"] == null
            ? null
            : DateTime.parse(json["date_available"]),
        weight: json["weight"] == null ? null : json["weight"],
        weightClassId:
            json["weight_class_id"] == null ? null : json["weight_class_id"],
        length: json["length"] == null ? null : json["length"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        lengthClassId:
            json["length_class_id"] == null ? null : json["length_class_id"],
        subtract: json["subtract"] == null ? null : json["subtract"],
        minimum: json["minimum"] == null ? null : json["minimum"],
        sortOrder: json["sort_order"] == null ? null : json["sort_order"],
        status: json["status"] == null ? null : json["status"],
        viewed: json["viewed"] == null ? null : json["viewed"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        languageId: json["language_id"] == null ? null : json["language_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        tag: json["tag"] == null ? null : json["tag"],
        metaTitle: json["meta_title"] == null ? null : json["meta_title"],
        metaDescription:
            json["meta_description"] == null ? null : json["meta_description"],
        metaKeyword: json["meta_keyword"] == null ? null : json["meta_keyword"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId == null ? null : productId,
        "model": model == null ? null : model,
        "sku": sku == null ? null : sku,
        "upc": upc == null ? null : upc,
        "ean": ean == null ? null : ean,
        "jan": jan == null ? null : jan,
        "isbn": isbn == null ? null : isbn,
        "mpn": mpn == null ? null : mpn,
        "location": location == null ? null : location,
        "quantity": quantity == null ? null : quantity,
        "stock_status_id": stockStatusId == null ? null : stockStatusId,
        "image": image == null ? null : image,
        "manufacturer_id": manufacturerId == null ? null : manufacturerId,
        "shipping": shipping == null ? null : shipping,
        "price": price == null ? null : price,
        "points": points == null ? null : points,
        "tax_class_id": taxClassId == null ? null : taxClassId,
        "date_available": dateAvailable == null
            ? null
            : "${dateAvailable.year.toString().padLeft(4, '0')}-${dateAvailable.month.toString().padLeft(2, '0')}-${dateAvailable.day.toString().padLeft(2, '0')}",
        "weight": weight == null ? null : weight,
        "weight_class_id": weightClassId == null ? null : weightClassId,
        "length": length == null ? null : length,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "length_class_id": lengthClassId == null ? null : lengthClassId,
        "subtract": subtract == null ? null : subtract,
        "minimum": minimum == null ? null : minimum,
        "sort_order": sortOrder == null ? null : sortOrder,
        "status": status == null ? null : status,
        "viewed": viewed == null ? null : viewed,
        "date_added": dateAdded == null ? null : dateAdded.toIso8601String(),
        "date_modified":
            dateModified == null ? null : dateModified.toIso8601String(),
        "language_id": languageId == null ? null : languageId,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "tag": tag == null ? null : tag,
        "meta_title": metaTitle == null ? null : metaTitle,
        "meta_description": metaDescription == null ? null : metaDescription,
        "meta_keyword": metaKeyword == null ? null : metaKeyword,
      };
}
