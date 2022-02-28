class EnumValues<T> {
  Map<String, T> maps;
  Map<T, String> reverseMap;

  EnumValues(this.maps);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = maps.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

enum ConnectivityStatus { WiFi, Cellular, Offline }
