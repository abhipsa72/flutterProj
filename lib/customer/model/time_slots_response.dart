TimeSlotsResponse timeSlotsFromMap(dynamic str) =>
    TimeSlotsResponse.fromMap(str);

class TimeSlotsResponse {
  TimeSlotsResponse({
    this.timeslots,
  });

  List<Timeslot> timeslots;

  factory TimeSlotsResponse.fromMap(Map<String, dynamic> json) =>
      TimeSlotsResponse(
        timeslots: json["timeslots"] == null
            ? null
            : List<Timeslot>.from(
                json["timeslots"].map((x) => Timeslot.fromMap(x))),
      );
}

class Timeslot {
  Timeslot({
    this.key,
    this.text,
  });

  String key;
  String text;

  factory Timeslot.fromMap(Map<String, dynamic> json) => Timeslot(
        key: json["key"] == null ? null : json["key"],
        text: json["text"] == null ? null : json["text"],
      );
}
