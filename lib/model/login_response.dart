// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:zel_app/util/enum_values.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromMap(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toMap());

class LoginResponse {
  bool loggedIn;
  User user;

  LoginResponse({
    this.loggedIn,
    this.user,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        loggedIn: json["loggedIn"] == null ? null : json["loggedIn"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "loggedIn": loggedIn == null ? null : loggedIn,
        "user": user == null ? null : user.toMap(),
      };
}

class User {
  String id;
  String name;
  String emailId;
  String contactNumber;
  String password;
  String authToken;
  Roles roles;
  String companyId;
  String storeName;
  String region;

  User(
      {this.id,
      this.name,
      this.emailId,
      this.contactNumber,
      this.password,
      this.authToken,
      this.roles,
      this.companyId,
      this.storeName,
      this.region});

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        emailId: json["emailId"] == null ? null : json["emailId"],
        contactNumber:
            json["contactNumber"] == null ? null : json["contactNumber"],
        password: json["password"] == null ? null : json["password"],
        authToken: json["authToken"] == null ? null : json["authToken"],
        roles: json["roles"] == null
            ? Roles.ROLE_STORE_MANAGER
            : rolesMap.maps[json["roles"]],
        companyId: json["companyId"] == null ? null : json["companyId"],
        storeName: json["storeName"] == null ? null : json["storeName"],
        region: json["region"] == null ? null : json["region"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "emailId": emailId == null ? null : emailId,
        "contactNumber": contactNumber == null ? null : contactNumber,
        "password": password == null ? null : password,
        "authToken": authToken == null ? null : authToken,
        "roles": roles == null ? null : roles,
        "companyId": companyId == null ? null : companyId,
        "storeName": storeName == null ? null : storeName,
        "region": region == null ? null : region,
      };
}

enum Roles {
  ROLE_STORE_MANAGER,
  ROLE_WAREHOUSE_MANAGER,
  ROLE_PURCHASER,
  ROLE_FINANCE,
  ROLE_ANALYTICS,
  ROLE_MD,
  ROLE_AGENT,
  ROLE_IT,
  ROLE_RCA,
  Stock_manager,
}

final rolesMap = EnumValues({
  "ROLE_STOREMANAGER": Roles.ROLE_STORE_MANAGER,
  "ROLE_WAREHOUSE_MANAGER": Roles.ROLE_WAREHOUSE_MANAGER,
  "ROLE_PURCHASER": Roles.ROLE_PURCHASER,
  "ROLE_FINANCE": Roles.ROLE_FINANCE,
  "ROLE_ANALYTICS": Roles.ROLE_ANALYTICS,
  "ROLE_MD": Roles.ROLE_MD,
  "ROLE_AGENT": Roles.ROLE_AGENT,
  "ROLE_IT": Roles.ROLE_IT,
  "ROLE_RCA": Roles.ROLE_RCA,
  "Stock_manager": Roles.Stock_manager
});
