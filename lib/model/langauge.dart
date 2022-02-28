// To parse this JSON data, do
//
//     final language = languageFromJson(jsonString);

import 'dart:convert';

import 'package:zel_app/util/enum_values.dart';

List<String> languageFromJson(List str) => List<String>.from(str.map((x) => x));

String languageToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));

List<Language> selectedLanguageFromJson(List str) =>
    List<Language>.from(str.map((x) => Language.fromJson(x)));

String selectedLanguageToJson(List<Language> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Language {
  LanguageCode languageCode;
  String key;
  String value;

  Language({
    this.languageCode,
    this.key,
    this.value,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        languageCode: languageCodeValues.maps[json["languageCode"]],
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "languageCode": languageCodeValues.reverse[languageCode],
        "key": key,
        "value": value,
      };
}

enum LanguageCode { ENGLISH, HINDI, ARABIC }

final languageCodeValues = EnumValues({
  "English": LanguageCode.ENGLISH,
  "Hindi": LanguageCode.HINDI,
  "Arabic": LanguageCode.ARABIC,
});
