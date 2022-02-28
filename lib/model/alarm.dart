// To parse this JSON data, do
//
//     final alarmResponse = alarmResponseFromJson(jsonString);

import 'dart:convert';

List<Alarm> alarmResponseFromJson(List str) =>
    List<Alarm>.from(str.map((x) => Alarm.fromMap(x)));

String alarmResponseToJson(List<Alarm> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Alarm {
  String id;
  String alarmName;

  Alarm({
    this.id,
    this.alarmName,
  });

  factory Alarm.fromJson(String str) => Alarm.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Alarm.fromMap(Map<String, dynamic> json) => Alarm(
        id: json["id"] == null ? null : json["id"],
        alarmName: json["alarmName"] == null ? null : json["alarmName"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "alarmName": alarmName == null ? null : alarmName,
      };
}
