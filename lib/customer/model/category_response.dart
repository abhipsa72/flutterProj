// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

CategoryResponse categoryFromHJson(dynamic str) =>
    CategoryResponse.fromJson(str);

class CategoryResponse {
  CategoryResponse({
    this.success,
  });

  Success success;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        success: Success.fromJson(json["success"]),
      );
}

class Success {
  Success({
    this.categories,
  });

  List<Category> categories;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromMap(x))),
      );
}

class Category {
  String categoryId;
  String image;
  String parentId;
  String top;
  String column;
  String sortOrder;
  String status;
  DateTime dateAdded;
  DateTime dateModified;
  String secondaryImage;
  String alternativeImage;
  String isFeatured;
  String languageId;
  String name;
  String description;
  String metaTitle;
  String metaDescription;
  String metaKeyword;
  String storeId;

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
    this.secondaryImage,
    this.alternativeImage,
    this.isFeatured,
    this.languageId,
    this.name,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.metaKeyword,
    this.storeId,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"] == null ? null : json["category_id"],
        image: json["image"] == null ? null : json["image"],
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
        secondaryImage:
            json["secondary_image"] == null ? null : json["secondary_image"],
        alternativeImage: json["alternative_image"] == null
            ? null
            : json["alternative_image"],
        isFeatured: json["is_featured"] == null ? null : json["is_featured"],
        languageId: json["language_id"] == null ? null : json["language_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        metaTitle: json["meta_title"] == null ? null : json["meta_title"],
        metaDescription:
            json["meta_description"] == null ? null : json["meta_description"],
        metaKeyword: json["meta_keyword"] == null ? null : json["meta_keyword"],
        storeId: json["store_id"] == null ? null : json["store_id"],
      );

  @override
  String toString() {
    return 'Category{categoryId: $categoryId, name: $name}';
  }
}
