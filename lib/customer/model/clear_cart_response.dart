// To parse this JSON data, do
//
//     final successResponse = successResponseFromJson(jsonString);

ClearCartResponse clearCartFromJson(dynamic str) =>
    ClearCartResponse.fromJson(str);

class ClearCartResponse {
  ClearCartResponse({
    this.success,
  });

  Success success;

  factory ClearCartResponse.fromJson(Map<String, dynamic> json) =>
      ClearCartResponse(
        success:
            json["success"] == null ? null : Success.fromJson(json["success"]),
      );
}

class Success {
  Success({
    this.message,
  });

  String message;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        message: json["message"] == null ? null : json["message"],
      );
}
