// To parse this JSON data, do
//
//     final zoneListResponse = zoneListResponseFromMap(jsonString);

ZoneListResponse zoneListFromMap(dynamic str) => ZoneListResponse.fromMap(str);

class ZoneListResponse {
  ZoneListResponse({
    this.zones,
  });

  List<Zone> zones;

  factory ZoneListResponse.fromMap(Map<String, dynamic> json) =>
      ZoneListResponse(
        zones: json["Zones"] == null
            ? []
            : List<Zone>.from(json["Zones"].map((x) => Zone.fromMap(x))),
      );
}

class Zone {
  Zone({
    this.zoneId,
    this.countryId,
    this.name,
    this.code,
    this.status,
  });

  String zoneId;
  String countryId;
  String name;
  String code;
  String status;

  factory Zone.fromMap(Map<String, dynamic> json) => Zone(
        zoneId: json["zone_id"] == null ? null : json["zone_id"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
        status: json["status"] == null ? null : json["status"],
      );
}
