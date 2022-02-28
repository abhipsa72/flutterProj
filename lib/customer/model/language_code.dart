LanguageListResponse languageListFromMap(dynamic str) =>
    LanguageListResponse.fromMap(str);

class LanguageListResponse {
  LanguageListResponse({
    this.success,
  });

  Success success;

  factory LanguageListResponse.fromMap(Map<String, dynamic> json) =>
      LanguageListResponse(
        success:
            json["success"] == null ? null : Success.fromMap(json["success"]),
      );
}

class Success {
  Success({
    this.languages,
  });

  List<Language> languages;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        languages: json["languages"] == null
            ? null
            : List<Language>.from(
                json["languages"].map((x) => Language.fromMap(x))),
      );
}

class Language {
  Language({
    this.languageId,
    this.name,
    this.code,
    this.locale,
    this.image,
    this.directory,
    this.sortOrder,
    this.status,
  });

  String languageId;
  String name;
  String code;
  String locale;
  String image;
  String directory;
  String sortOrder;
  String status;

  factory Language.fromMap(Map<String, dynamic> json) => Language(
        languageId: json["language_id"] == null ? null : json["language_id"],
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
        locale: json["locale"] == null ? null : json["locale"],
        image: json["image"] == null ? null : json["image"],
        directory: json["directory"] == null ? null : json["directory"],
        sortOrder: json["sort_order"] == null ? null : json["sort_order"],
        status: json["status"] == null ? null : json["status"],
      );
}
