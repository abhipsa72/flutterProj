import 'dart:convert';

CategoryResponse adminCategoriesFromMap(dynamic str) =>
    CategoryResponse.fromMap(str);

String categoryResponseToMap(CategoryResponse data) =>
    json.encode(data.toMap());

class CategoryResponse {
  CategoryResponse({
    this.success,
  });

  Success success;

  factory CategoryResponse.fromMap(Map<String, dynamic> json) =>
      CategoryResponse(
        success:
            json["success"] == null ? null : Success.fromMap(json["success"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success.toMap(),
      };
}

class Success {
  Success({
    this.categories,
  });

  List<Category> categories;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x.toMap())),
      };
}

class Category {
  Category({
    this.categoryId,
    this.image,
    this.parentId,
    this.top,
    this.column,
    this.sortOrder,
    this.status,
    this.dateAdded,
    this.dateModified,
    this.languageId,
    this.name,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.metaKeyword,
    this.storeId,
    this.level,
  });

  String categoryId;
  dynamic image;
  String parentId;
  String top;
  String column;
  String sortOrder;
  String status;
  DateTime dateAdded;
  DateTime dateModified;
  String languageId;
  String name;
  String description;
  String metaTitle;
  String metaDescription;
  String metaKeyword;
  String storeId;
  String level;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"] == null ? null : json["category_id"],
        image: json["image"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        top: json["top"] == null ? null : json["top"],
        column: json["column"] == null ? null : json["column"],
        sortOrder: json["sort_order"] == null ? null : json["sort_order"],
        status: json["status"] == null ? null : json["status"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        languageId: json["language_id"] == null ? null : json["language_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        metaTitle: json["meta_title"] == null ? null : json["meta_title"],
        metaDescription:
            json["meta_description"] == null ? null : json["meta_description"],
        metaKeyword: json["meta_keyword"] == null ? null : json["meta_keyword"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        level: json["level"] == null ? null : json["level"],
      );

  Map<String, dynamic> toMap() => {
        "category_id": categoryId == null ? null : categoryId,
        "image": image,
        "parent_id": parentId == null ? null : parentId,
        "top": top == null ? null : top,
        "column": column == null ? null : column,
        "sort_order": sortOrder == null ? null : sortOrder,
        "status": status == null ? null : status,
        "date_added": dateAdded == null ? null : dateAdded.toIso8601String(),
        "date_modified":
            dateModified == null ? null : dateModified.toIso8601String(),
        "language_id": languageId == null ? null : languageId,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "meta_title": metaTitle == null ? null : metaTitle,
        "meta_description": metaDescription == null ? null : metaDescription,
        "meta_keyword": metaKeyword == null ? null : metaKeyword,
        "store_id": storeId == null ? null : storeId,
        "level": level == null ? null : level,
      };
}
