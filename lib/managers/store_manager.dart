import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/util/dio_network.dart';

class StoreManager {
  final _dio = DioNetworkUtil();

  Future<Response> homeDetails() async {
    return _dio.get("path");
  }

  Future<Response> details(String authToken, String companyId, String fromDate,
      String endDate) async {
    return _dio.post(
      "data",
      params: {
        "companyId": companyId,
        "from": fromDate,
        "to": endDate,
        "mtoken": authToken
      },
    );
  }

  Future<Response> barChart(String authToken, String companyId, String fromDate,
      String endDate) async {
    return _dio.post(
      "barChart",
      params: {
        "companyId": companyId,
        "from": fromDate,
        "to": endDate,
        "mtoken": authToken
      },
    );
  }

  Future<Response> pieChart(String authToken, String companyId, String fromDate,
      String endDate) async {
    return _dio.post(
      "doughnutChart",
      params: {
        "companyId": companyId,
        "from": fromDate,
        "to": endDate,
        "mtoken": authToken
      },
    );
  }

  Future<Response> lineChart(String authToken, String companyId,
      String fromDate, String endDate) async {
    return _dio.post(
      "lineChart",
      params: {
        "companyId": companyId,
        "from": fromDate,
        "to": endDate,
        "mtoken": authToken
      },
    );
  }

  Future<Response> lineFiler(String authToken, String fromDate, String endDate,
      String companyId, String value) async {
    return _dio.post(
      "barChartClickEventLine",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "companyId": companyId,
        "value": value
      },
    );
  }

//  Future<Response> donughtFiler(String authToken,
//      String fromDate, String endDate,String companyId,String value) async {
//    return _dio.post(
//      "bubbleChartClickEventDoughnut",
//      params: {
//        "mtoken": authToken,
//        "from": fromDate,
//        "to": endDate,
//        "companyId": companyId,
//        "value" : value
//      },
//    );
//  }
  Future<Response> bubbleChart(String authToken, String companyId,
      String fromDate, String endDate) async {
    return _dio.post(
      "bubbleChart",
      params: {
        "companyId": companyId,
        "from": fromDate,
        "to": endDate,
        "mtoken": authToken
      },
    );
  }

  Future<Response> actionTable(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) {
    return _dio.post(
      "getWIPAlrmsByRole",
      params: {
        "from": null,
        "mtoken": authToken,
        "role": describeEnum(roles),
        "to": null
      },
    );
  }
}
