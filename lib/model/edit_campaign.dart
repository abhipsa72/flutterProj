import 'dart:convert';

import 'package:zel_app/model/existing_campaign.dart';

EditCampaignModel editCampaignModelFroJson(dynamic str) =>
    EditCampaignModel.fromMap(str);

String editCampaignModelToJson(EditCampaignModel data) =>
    json.encode(data.toMap());

class EditCampaignModel {
  EditCampaignModel({
    this.status,
    this.message,
    this.actionList,
  });

  final bool status;
  final String message;
  final ExistingCampaignModel actionList;

  factory EditCampaignModel.fromMap(Map<String, dynamic> json) =>
      EditCampaignModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        actionList: json["actionList"] == null
            ? null
            : ExistingCampaignModel.fromMap(json["actionList"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "actionList": actionList == null ? null : actionList.toMap(),
      };
}
