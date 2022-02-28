// To parse this JSON data, do
//
//     final mininumOrder = mininumOrderFromJson(jsonString);

import 'dart:convert';

MinimumOrderResponse minimumOrderFromJson(String str) =>
    MinimumOrderResponse.fromMap(json.decode(str));

class MinimumOrderResponse {
  Minimum minimum;

  MinimumOrderResponse({
    this.minimum,
  });

  factory MinimumOrderResponse.fromMap(Map<String, dynamic> json) =>
      MinimumOrderResponse(
        minimum: json["row"] == null
            ? null
            : Minimum.fromMap(
                json["row"],
              ),
      );
}

class Minimum {
  String motId;
  String motTotal;
  String motGeoZoneId;
  String motStatus;

  Minimum({
    this.motId,
    this.motTotal,
    this.motGeoZoneId,
    this.motStatus,
  });

  factory Minimum.fromMap(Map<String, dynamic> json) => Minimum(
        motId: json["mot_id"] == null ? null : json["mot_id"],
        motTotal: json["mot_total"] == null ? null : json["mot_total"],
        motGeoZoneId:
            json["mot_geo_zone_id"] == null ? null : json["mot_geo_zone_id"],
        motStatus: json["mot_status"] == null ? null : json["mot_status"],
      );
}
