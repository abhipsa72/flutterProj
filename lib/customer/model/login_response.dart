// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

LoginResponse userFromJson(dynamic str) => LoginResponse.fromJson(str);

class LoginResponse {
  LoginResponse({
    this.success,
    this.error,
  });

  Error error;
  Success success;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"] == null
            ? null
            : Success.fromJson(
                json["success"],
              ),
        error: json["error"] == null
            ? null
            : Error.fromJson(
                json["error"],
              ),
      );
}

class Error {
  String message;

  Error({this.message});

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json['message'] == null ? null : json['message'],
      );
}

class Success {
  Success({
    this.apiToken,
    this.user,
    this.message,
  });

  String apiToken;
  User user;
  String message;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        apiToken: json["api_token"] == null ? null : json["api_token"],
        user: json["data"] == null
            ? null
            : User.fromJson(
                json["data"],
              ),
        message: json["message"] == null ? null : json["message"],
      );
}

class User {
  User({
    this.customerId,
    this.customerGroupId,
    this.storeId,
    this.languageId,
    this.firstname,
    this.lastname,
    this.email,
    this.telephone,
    this.fax,
    this.salt,
    this.cart,
    this.wishlist,
    this.newsletter,
    this.addressId,
    this.ip,
    this.status,
    this.safe,
    this.dateAdded,
  });

  String customerId;
  String customerGroupId;
  String storeId;
  String languageId;
  String firstname;
  String lastname;
  String email;
  String telephone;
  String fax;
  String salt;
  dynamic cart;
  dynamic wishlist;
  String newsletter;
  String addressId;
  String ip;
  String status;
  String safe;
  DateTime dateAdded;

  String fullName() => '$firstname $lastname';

  factory User.fromJson(Map<String, dynamic> json) => User(
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        customerGroupId: json["customer_group_id"] == null
            ? null
            : json["customer_group_id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        languageId: json["language_id"] == null ? null : json["language_id"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        email: json["email"] == null ? null : json["email"],
        telephone: json["telephone"] == null ? null : json["telephone"],
        fax: json["fax"] == null ? null : json["fax"],
        salt: json["salt"] == null ? null : json["salt"],
        cart: json["cart"],
        wishlist: json["wishlist"],
        newsletter: json["newsletter"] == null ? null : json["newsletter"],
        addressId: json["address_id"] == null ? null : json["address_id"],
        ip: json["ip"] == null ? null : json["ip"],
        status: json["status"] == null ? null : json["status"],
        safe: json["safe"] == null ? null : json["safe"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
      );
}
