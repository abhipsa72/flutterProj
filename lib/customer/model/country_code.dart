// To parse this JSON data, do
//
//     final countryListResponse = countryListResponseFromJson(jsonString);

CountryListResponse countryListFromMap(dynamic str) =>
    CountryListResponse.fromJson(str);

class CountryListResponse {
  CountryListResponse({
    this.success,
  });

  Success success;

  factory CountryListResponse.fromJson(Map<String, dynamic> json) =>
      CountryListResponse(
        success:
            json["success"] == null ? null : Success.fromJson(json["success"]),
      );
}

class Success {
  Success({
    this.countries,
  });

  List<Country> countries;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        countries: json["countries"] == null
            ? null
            : List<Country>.from(
                json["countries"].map((x) => Country.fromJson(x))),
      );
}

class Country {
  Country({
    this.countryId,
    this.name,
    this.isoCode2,
    this.isoCode3,
    this.addressFormat,
    this.postcodeRequired,
    this.status,
  });

  String countryId;
  String name;
  String isoCode2;
  String isoCode3;
  String addressFormat;
  String postcodeRequired;
  String status;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryId: json["country_id"] == null ? null : json["country_id"],
        name: json["name"] == null ? null : json["name"],
        isoCode2: json["iso_code_2"] == null ? null : json["iso_code_2"],
        isoCode3: json["iso_code_3"] == null ? null : json["iso_code_3"],
        addressFormat:
            json["address_format"] == null ? null : json["address_format"],
        postcodeRequired: json["postcode_required"] == null
            ? null
            : json["postcode_required"],
        status: json["status"] == null ? null : json["status"],
      );
}
