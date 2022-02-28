import 'package:grand_uae/customer/enums/stock_status.dart';
import 'package:grand_uae/customer/model/cart_products_response.dart';

class Product {
  Product({
    this.productId,
    this.name,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.metaKeyword,
    this.tag,
    this.model,
    this.sku,
    this.upc,
    this.ean,
    this.jan,
    this.isbn,
    this.mpn,
    this.location,
    this.quantity,
    this.stockStatus,
    this.image,
    this.manufacturerId,
    this.manufacturer,
    this.price,
    this.special,
    this.reward,
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
    this.rating,
    this.reviews,
    this.minimum,
    this.sortOrder,
    this.status,
    this.dateAdded,
    this.dateModified,
    this.viewed,
    this.cartId,
    this.stock,
    this.shipping,
    this.option,
    this.wishList,
  });

  bool wishList;
  List<dynamic> option;
  String shipping;
  bool stock;
  String cartId;
  String productId;
  String name;
  String description;
  String metaTitle;
  String metaDescription;
  String metaKeyword;
  String tag;
  String model;
  String sku;
  String upc;
  String ean;
  String jan;
  String isbn;
  String mpn;
  String location;
  String quantity;
  StockStatus stockStatus;
  String image;
  String manufacturerId;
  String manufacturer;
  String price;
  dynamic special;
  dynamic reward;
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
  int rating;
  dynamic reviews;
  String minimum;
  String sortOrder;
  dynamic status;
  DateTime dateAdded;
  DateTime dateModified;
  String viewed;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        productId: json["product_id"] == null ? null : json["product_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        metaTitle: json["meta_title"] == null ? null : json["meta_title"],
        metaDescription:
            json["meta_description"] == null ? null : json["meta_description"],
        metaKeyword: json["meta_keyword"] == null ? null : json["meta_keyword"],
        tag: json["tag"] == null ? null : json["tag"],
        model: json["model"] == null ? null : json["model"],
        sku: json["sku"] == null ? null : json["sku"],
        upc: json["upc"] == null ? null : json["upc"],
        ean: json["ean"] == null ? null : json["ean"],
        jan: json["jan"] == null ? null : json["jan"],
        isbn: json["isbn"] == null ? null : json["isbn"],
        mpn: json["mpn"] == null ? null : json["mpn"],
        location: json["location"] == null ? null : json["location"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        stockStatus: json["stock_status"] == null
            ? null
            : stockStatusValues.map[json["stock_status"]],
        image: json["image"] == null ? null : json["image"],
        manufacturerId:
            json["manufacturer_id"] == null ? null : json["manufacturer_id"],
        manufacturer:
            json["manufacturer"] == null ? null : json["manufacturer"],
        price: json["price"] == null ? null : json["price"],
        special: json["special"],
        reward: json["reward"],
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
        rating: json["rating"] == null ? null : json["rating"],
        reviews: json["reviews"] == null ? null : json["reviews"],
        minimum: json["minimum"] == null ? null : json["minimum"],
        sortOrder: json["sort_order"] == null ? null : json["sort_order"],
        status: json["status"] == null ? null : json["status"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        viewed: json["viewed"] == null ? null : json["viewed"],
        cartId: json["cart_id"] == null ? null : json["cart_id"],
        stock: json["stock"] == null ? null : json["stock"],
        wishList: json["wishlist"] == null ? false : json["wishlist"],
        option: json["option"] == null
            ? null
            : List<dynamic>.from(json["option"].map((x) => x)),
        shipping: json["shipping"] == null ? null : json["shipping"],
      );
}
