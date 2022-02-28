import 'dart:convert';

List<RecommendationSummaryModel> recommendationSummaryFromJson(List str) =>
    List<RecommendationSummaryModel>.from(
        str.map((x) => RecommendationSummaryModel.fromMap(x)));

String recommendationSummaryToJson(List<RecommendationSummaryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class RecommendationSummaryModel {
  RecommendationSummaryModel({
    this.campigns,
  });

  final Campigns campigns;

  factory RecommendationSummaryModel.fromMap(Map<String, dynamic> json) =>
      RecommendationSummaryModel(
        campigns: json["campigns"] == null
            ? null
            : Campigns.fromMap(json["campigns"]),
      );

  Map<String, dynamic> toMap() => {
        "campigns": campigns == null ? null : campigns.toMap(),
      };
}

class Campigns {
  Campigns({
    this.inactive,
    this.prevention,
    this.redemption,
    this.structuralInactive,
    this.uplift,
  });

  final Inactive inactive;
  final Prevention prevention;
  final Prevention redemption;
  final StructuralInactive structuralInactive;
  final Prevention uplift;

  factory Campigns.fromMap(Map<String, dynamic> json) => Campigns(
        inactive: json["Inactive"] == null
            ? null
            : Inactive.fromMap(json["Inactive"]),
        prevention: json["Prevention"] == null
            ? null
            : Prevention.fromMap(json["Prevention"]),
        redemption: json["Redemption"] == null
            ? null
            : Prevention.fromMap(json["Redemption"]),
        structuralInactive: json["Structural_Inactive"] == null
            ? null
            : StructuralInactive.fromMap(json["Structural_Inactive"]),
        uplift:
            json["Uplift"] == null ? null : Prevention.fromMap(json["Uplift"]),
      );

  Map<String, dynamic> toMap() => {
        "Inactive": inactive == null ? null : inactive.toMap(),
        "Prevention": prevention == null ? null : prevention.toMap(),
        "Redemption": redemption == null ? null : redemption.toMap(),
        "Structural_Inactive":
            structuralInactive == null ? null : structuralInactive.toMap(),
        "Uplift": uplift == null ? null : uplift.toMap(),
      };
}

class Inactive {
  Inactive({
    this.call,
    this.callFlagtag,
    this.callSms,
    this.callSmsFlagtag,
    this.sms,
    this.smsFlagtag,
  });

  final int call;
  final Flagtag callFlagtag;
  final int callSms;
  final CallFlagtag callSmsFlagtag;
  final int sms;
  final Flagtag smsFlagtag;

  factory Inactive.fromMap(Map<String, dynamic> json) => Inactive(
        call: json["call"] == null ? null : json["call"],
        callFlagtag: json["call_flagtag"] == null
            ? null
            : Flagtag.fromMap(json["call_flagtag"]),
        callSms: json["call, sms"] == null ? null : json["call, sms"],
        callSmsFlagtag: json["call, sms_flagtag"] == null
            ? null
            : CallFlagtag.fromMap(json["call, sms_flagtag"]),
        sms: json["sms"] == null ? null : json["sms"],
        smsFlagtag: json["sms_flagtag"] == null
            ? null
            : Flagtag.fromMap(json["sms_flagtag"]),
      );

  Map<String, dynamic> toMap() => {
        "call": call == null ? null : call,
        "call_flagtag": callFlagtag == null ? null : callFlagtag.toMap(),
        "call, sms": callSms == null ? null : callSms,
        "call, sms_flagtag":
            callSmsFlagtag == null ? null : callSmsFlagtag.toMap(),
        "sms": sms == null ? null : sms,
        "sms_flagtag": smsFlagtag == null ? null : smsFlagtag.toMap(),
      };
}

class Flagtag {
  Flagtag({
    this.control,
    this.test,
  });

  final SmsFlagtagControl control;
  final SmsFlagtagControl test;

  factory Flagtag.fromMap(Map<String, dynamic> json) => Flagtag(
        control: json["control"] == null
            ? null
            : SmsFlagtagControl.fromMap(json["control"]),
        test: json["test"] == null
            ? null
            : SmsFlagtagControl.fromMap(json["test"]),
      );

  Map<String, dynamic> toMap() => {
        "control": control == null ? null : control.toMap(),
        "test": test == null ? null : test.toMap(),
      };
}

class SmsFlagtagControl {
  SmsFlagtagControl({
    this.targetNumber,
    this.averagePreTransaction,
    this.averagePreBasket,
  });

  final int targetNumber;
  final double averagePreTransaction;
  final int averagePreBasket;

  factory SmsFlagtagControl.fromMap(Map<String, dynamic> json) =>
      SmsFlagtagControl(
        targetNumber:
            json["target_number"] == null ? null : json["target_number"],
        averagePreTransaction: json["average_pre_transaction"] == null
            ? null
            : json["average_pre_transaction"].toDouble(),
        averagePreBasket: json["average_pre_basket"] == null
            ? null
            : json["average_pre_basket"],
      );

  Map<String, dynamic> toMap() => {
        "target_number": targetNumber == null ? null : targetNumber,
        "average_pre_transaction":
            averagePreTransaction == null ? null : averagePreTransaction,
        "average_pre_basket":
            averagePreBasket == null ? null : averagePreBasket,
      };
}

class CallFlagtag {
  CallFlagtag({
    this.control,
    this.test,
  });

  final PurpleControl control;
  final PurpleControl test;

  factory CallFlagtag.fromMap(Map<String, dynamic> json) => CallFlagtag(
        control: json["control"] == null
            ? null
            : PurpleControl.fromMap(json["control"]),
        test: json["test"] == null ? null : PurpleControl.fromMap(json["test"]),
      );

  Map<String, dynamic> toMap() => {
        "control": control == null ? null : control.toMap(),
        "test": test == null ? null : test.toMap(),
      };
}

class PurpleControl {
  PurpleControl({
    this.targetNumber,
    this.averagePreTransaction,
    this.averagePreBasket,
  });

  final int targetNumber;
  final String averagePreTransaction;
  final String averagePreBasket;

  factory PurpleControl.fromMap(Map<String, dynamic> json) => PurpleControl(
        targetNumber:
            json["target_number"] == null ? null : json["target_number"],
        averagePreTransaction: json["average_pre_transaction"] == null
            ? null
            : json["average_pre_transaction"],
        averagePreBasket: json["average_pre_basket"] == null
            ? null
            : json["average_pre_basket"],
      );

  Map<String, dynamic> toMap() => {
        "target_number": targetNumber == null ? null : targetNumber,
        "average_pre_transaction":
            averagePreTransaction == null ? null : averagePreTransaction,
        "average_pre_basket":
            averagePreBasket == null ? null : averagePreBasket,
      };
}

class Prevention {
  Prevention({
    this.call,
    this.callFlagtag,
    this.callSms,
    this.callSmsFlagtag,
    this.sms,
    this.smsFlagtag,
  });

  final int call;
  final Flagtag callFlagtag;
  final int callSms;
  final Flagtag callSmsFlagtag;
  final int sms;
  final Flagtag smsFlagtag;

  factory Prevention.fromMap(Map<String, dynamic> json) => Prevention(
        call: json["call"] == null ? null : json["call"],
        callFlagtag: json["call_flagtag"] == null
            ? null
            : Flagtag.fromMap(json["call_flagtag"]),
        callSms: json["call, sms"] == null ? null : json["call, sms"],
        callSmsFlagtag: json["call, sms_flagtag"] == null
            ? null
            : Flagtag.fromMap(json["call, sms_flagtag"]),
        sms: json["sms"] == null ? null : json["sms"],
        smsFlagtag: json["sms_flagtag"] == null
            ? null
            : Flagtag.fromMap(json["sms_flagtag"]),
      );

  Map<String, dynamic> toMap() => {
        "call": call == null ? null : call,
        "call_flagtag": callFlagtag == null ? null : callFlagtag.toMap(),
        "call, sms": callSms == null ? null : callSms,
        "call, sms_flagtag":
            callSmsFlagtag == null ? null : callSmsFlagtag.toMap(),
        "sms": sms == null ? null : sms,
        "sms_flagtag": smsFlagtag == null ? null : smsFlagtag.toMap(),
      };
}

class StructuralInactive {
  StructuralInactive({
    this.call,
    this.callFlagtag,
    this.callSms,
    this.callSmsFlagtag,
    this.sms,
    this.smsFlagtag,
  });

  final int call;
  final CallFlagtag callFlagtag;
  final int callSms;
  final CallFlagtag callSmsFlagtag;
  final int sms;
  final Flagtag smsFlagtag;

  factory StructuralInactive.fromMap(Map<String, dynamic> json) =>
      StructuralInactive(
        call: json["call"] == null ? null : json["call"],
        callFlagtag: json["call_flagtag"] == null
            ? null
            : CallFlagtag.fromMap(json["call_flagtag"]),
        callSms: json["call, sms"] == null ? null : json["call, sms"],
        callSmsFlagtag: json["call, sms_flagtag"] == null
            ? null
            : CallFlagtag.fromMap(json["call, sms_flagtag"]),
        sms: json["sms"] == null ? null : json["sms"],
        smsFlagtag: json["sms_flagtag"] == null
            ? null
            : Flagtag.fromMap(json["sms_flagtag"]),
      );

  Map<String, dynamic> toMap() => {
        "call": call == null ? null : call,
        "call_flagtag": callFlagtag == null ? null : callFlagtag.toMap(),
        "call, sms": callSms == null ? null : callSms,
        "call, sms_flagtag":
            callSmsFlagtag == null ? null : callSmsFlagtag.toMap(),
        "sms": sms == null ? null : sms,
        "sms_flagtag": smsFlagtag == null ? null : smsFlagtag.toMap(),
      };
}
