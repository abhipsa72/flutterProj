import 'dart:convert';

String addCategoryToMap(AddCategory data) => json.encode(data.toMap());

class AddCategory {
  AddCategory({
    this.categoryName,
    this.metaTitle,
    this.categoryDescription,
    this.parentId,
    this.column,
    this.sortOrder,
    this.status,
    this.top,
  });

  String categoryName;
  String metaTitle;
  String categoryDescription;
  int parentId;
  int column;
  int sortOrder;
  int status;
  int top;

  factory AddCategory.fromMap(Map<String, dynamic> json) => AddCategory(
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        metaTitle: json["meta_title"] == null ? null : json["meta_title"],
        categoryDescription: json["category_description"] == null
            ? null
            : json["category_description"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        column: json["column"] == null ? null : json["column"],
        sortOrder: json["sort_order"] == null ? null : json["sort_order"],
        status: json["status"] == null ? null : json["status"],
        top: json["top"] == null ? null : json["top"],
      );

  Map<String, dynamic> toMap() => {
        "category_name": categoryName == null ? null : categoryName,
        "meta_title": metaTitle == null ? null : metaTitle,
        "category_description":
            categoryDescription == null ? null : categoryDescription,
        "parent_id": parentId == null ? null : parentId,
        "column": column == null ? null : column,
        "sort_order": sortOrder == null ? null : sortOrder,
        "status": status == null ? null : status,
        "top": top == null ? null : top,
      };
}
