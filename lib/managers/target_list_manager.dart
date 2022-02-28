import 'package:dio/dio.dart';
import 'package:zel_app/util/dio_network.dart';

class MarketEngineManager {
  final _dio = DioNetworkUtil();

  Future<Response> targetListApi(String token) async {
    return _dio.get("targetList/1", params: {
      "mtoken": token,
    });
  }

  Future<Response> getLocation(String token) async {
    return _dio.get("customerLocation", params: {
      "mtoken": token,
    });
  }

  Future<Response> getChannel(String token) async {
    return _dio.get("channel", params: {
      "mtoken": token,
    });
  }

  Future<Response> getCampaign(String token) async {
    return _dio.get("campaign", params: {
      "mtoken": token,
    });
  }

  Future<Response> timePeriod(String token) async {
    return _dio.get("timePeriod", params: {
      "mtoken": token,
    });
  }

  Future<Response> filterTargetList(String token, String location,
      String channel, String timePeriod, String Campaign) async {
    return _dio.post("filterTargetList", params: {
      "mtoken": token,
      "location": location,
      "channel": channel,
      "timePeriod": timePeriod,
      "campaign": Campaign
    });
  }

  Future<Response> createAction(String token, String timePeriod,
      String campaignName, String targetlistIds) async {
    return _dio.post("createActionList", params: {
      "mtoken": token,
      "timePeriod": timePeriod,
      "actionListName": campaignName,
      "targetListIds": targetlistIds
    });
  }

  Future<Response> existingCampaign(String token) async {
    return _dio.get("actionList", params: {
      "mtoken": token,
    });
  }

  Future<Response> deleteCampaign(String token, String id) async {
    return _dio.delete("deleteActionList/$id", params: {"mtoken": token});
  }

  Future<Response> editAction(String token, String name, String id) async {
    return _dio.post("editActionList",
        params: {"mtoken": token, "name": name, "actionListId": id});
  }

  Future<Response> recomSummary(String token, String timePeriod) async {
    return _dio.post("recommendationSummary",
        params: {"mtoken": token, "timePeriod": timePeriod});
  }

  Future<Response> customerStatus(String token) async {
    return _dio.get("customerStatus", params: {"mtoken": token});
  }

  Future<Response> agentFeedback(String token, String actionListId,
      String targetListId, String agentFeedback, String value) async {
    return _dio.post("agentFeedback", params: {
      "mtoken": token,
      "actionListId": actionListId,
      "targetListId": targetListId,
      "agentFeedback": agentFeedback,
      "value": value
    });
  }
}
