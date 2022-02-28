// To parse this JSON data, do
//
//     final onMessageResponse = onMessageResponseFromMap(jsonString);

import 'dart:convert';

OnMessageResponse onMessageResponseFromMap(dynamic str) =>
    OnMessageResponse.fromMap(str);

String onMessageResponseToMap(OnMessageResponse data) =>
    json.encode(data.toMap());

class OnMessageResponse {
  OnMessageResponse({
    this.notification,
    this.data,
  });

  Notification notification;
  Data data;

  factory OnMessageResponse.fromMap(Map<String, dynamic> json) =>
      OnMessageResponse(
        notification: json["notification"] == null
            ? null
            : Notification.fromMap(json["notification"]),
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "notification": notification == null ? null : notification.toMap(),
        "data": data == null ? null : data.toMap(),
      };
}

class Data {
  Data({
    this.notificationType,
    this.clickAction,
    this.categoryName,
    this.categoryId,
    this.productId,
  });

  String notificationType;
  String clickAction;
  String categoryName;
  String categoryId;
  String productId;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        notificationType: json["notification_type"] == null
            ? null
            : json["notification_type"],
        clickAction: json["click_action"] == null ? null : json["click_action"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
      );

  Map<String, dynamic> toMap() => {
        "notification_type": notificationType == null ? null : notificationType,
        "click_action": clickAction == null ? null : clickAction,
        "category_name": categoryName == null ? null : categoryName,
        "category_id": categoryId == null ? null : categoryId,
        "product_id": productId == null ? null : productId,
      };
}

class Notification {
  Notification({
    this.title,
    this.body,
  });

  String title;
  String body;

  factory Notification.fromMap(Map<String, dynamic> json) => Notification(
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "body": body == null ? null : body,
      };
}
