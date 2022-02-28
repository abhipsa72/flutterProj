class AlarmDetailsResponse {
  int comp;
  int wip;
  int ua;

  AlarmDetailsResponse({this.comp, this.wip, this.ua});

  AlarmDetailsResponse.fromJson(Map<String, dynamic> json) {
    comp = json['comp'];
    wip = json['wip'];
    ua = json['ua'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comp'] = this.comp;
    data['wip'] = this.wip;
    data['ua'] = this.ua;
    return data;
  }
}
