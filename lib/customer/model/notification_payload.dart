// To parse this JSON data, do
//
//     final notificationPayload = notificationPayloadFromJson(jsonString);

NotificationPayload notificationPayloadFromJson(dynamic str) =>
    NotificationPayload.fromJson(str);

class NotificationPayload {
  NotificationPayload({
    this.notification,
    this.data,
  });

  Notification notification;
  Data data;

  factory NotificationPayload.fromJson(Map<String, dynamic> json) =>
      NotificationPayload(
        notification: Notification.fromJson(json["notification"]),
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.type,
    this.clickAction,
    this.categoryName,
    this.categoryId,
    this.productId,
  });

  String type;
  String clickAction;
  String categoryName;
  int categoryId;
  int productId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        clickAction: json["click_action"],
        categoryName: json["category_name"],
        categoryId: json["category_id"],
        productId: json["product_id"],
      );
}

class Notification {
  Notification({
    this.title,
    this.body,
  });

  String title;
  String body;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json["title"],
        body: json["body"],
      );
}
