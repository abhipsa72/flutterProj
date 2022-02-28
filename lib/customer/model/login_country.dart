// To parse this JSON data, do
//
//     final loginCountry = loginCountryFromJson(jsonString);

import 'dart:convert';

List<LoginCountry> loginCountryFromJson(String str) => List<LoginCountry>.from(
    json.decode(str).map((x) => LoginCountry.fromMap(x)));

class LoginCountry {
  String name;
  String apiKey;
  String userName;
  String countryCode;
  String countryName;

  LoginCountry(
      {this.name,
      this.apiKey,
      this.userName,
      this.countryCode,
      this.countryName});

  @override
  String toString() {
    return 'LoginCountry{name: $name, apiKey: $apiKey, userName: $userName, country: $countryCode}';
  }

  factory LoginCountry.fromMap(Map<String, dynamic> json) => LoginCountry(
        name: json["name"] == null ? null : json["name"],
        apiKey: json["api_key"] == null ? null : json["api_key"],
        userName: json["user_name"] == null ? null : json["user_name"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        countryName: json["country_name"] == null ? null : json["country_name"],
      );
}
