import 'package:dio/dio.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/util/dio_network.dart';

class ProductManager {
  final _dio = DioNetworkUtil();

  Future<Response> allAlarms(String token) {
    return _dio.get("getAllAlarms", params: {
      "mtoken": token,
    });
  }

  Future<Response> getActionsFromAlarm(String authToken, String alarm) {
    return _dio.get("getActions/$alarm", params: {
      "mtoken": authToken,
    });
  }

  Future<Response> flowProgres(String authToken, Roles roles, String fromDate,
      String endDate, String value, String companyId) async {
    return _dio.post(
      "resignedTask",
      params: {
        "role": rolesMap.reverse[roles],
        "from": fromDate,
        "to": endDate,
        "mtoken": authToken,
        "value": value,
        "companyId": companyId,
      },
    );
  }

  Future<Response> productList(
    String mToken,
    String companyId,
    String fromDate,
    String endDate,
  ) {
    return _dio.post(
      "getAllData",
      params: {
        "companyId": companyId,
        "from": fromDate,
        "to": endDate,
        "mtoken": mToken
      },
    );
  }

  Future<Response> updateRemarks(
    String mToken,
    String id,
    String companyId,
    String alarmName,
  ) {
    return _dio.post(
      "updateRemarks",
      params: {
        "mtoken": mToken,
        "id": id,
        "companyId": companyId,
        "alarmName": alarmName,
      },
    );
  }

  Future<Response> updateAction(
    String mToken,
    String id,
    String companyId,
    String actionName,
  ) {
    return _dio.post(
      "updateAction",
      params: {
        "mtoken": mToken,
        "id": id,
        "companyId": companyId,
        "actionName": actionName,
      },
    );
  }

//  Future<Response> updateActionProduct(
//    String mToken,
//    String companyId,
//    String fromDate,
//    String endDate,
//  ) {
//    return _dio.post(
//      "updateAction",
//      params: {
//        "mtoken": mToken,
//        "from": fromDate,
//        "companyId": companyId,
//        "to": endDate,
//      },
//    );
//  }

  Future<Response> getSubActionsFromAction(String mToken, String actionName) {
    return _dio.post(
      "getSubActions",
      params: {
        "mtoken": mToken,
        "actionName": actionName,
      },
    );
  }

  Future<Response> saveSubActionRemark(
    String mToken,
    String productId,
    String companyId,
    String subAction,
    String remarks,
    String barCode,
  ) {
    return _dio.post(
      "saveSubActionRemark",
      params: {
        "mtoken": mToken,
        "id": productId,
        "subAction": subAction,
        "remarks": remarks,
        "barCode": barCode,
      },
    );
  }

  Future<Response> saveDetails(
    String authToken,
    String productId,
    String subActionName,
    String remarkable,
    String barCode,
    String companyId,
  ) {
    return _dio.post(
      "saveSubActions",
      params: {
        "mtoken": authToken,
        "companyId": companyId,
        "id": productId,
        "subAction": subActionName,
        "remarks": remarkable,
        "barCode": barCode,
      },
    );
  }

  Future<Response> updateRole(String authToken, String productId, Roles roles) {
    return _dio.post(
      "setRoleToProduct",
      params: {
        "id": productId,
        "role": rolesMap.reverse[roles],
        "mtoken": authToken,
      },
    );
  }

  Future<Response> setRemarks(
      String remark, String productId, String authToken) {
    return _dio.post(
      "saveSubActionRemark",
      params: {
        "subActionRemark": remark,
        "id": productId,
        "mtoken": authToken,
      },
    );
  }

  Future<Response> filterAlaramStore(String authToken, String value,
      String fromDate, String companyId, String endDate) {
    return _dio.post(
      "workProgressionProductList",
      params: {
        "mtoken": authToken,
        "value": value,
        "from": fromDate,
        "companyId": companyId,
        "to": endDate
      },
    );
  }

  Future<Response> search(
    String companyId,
    String fromDate,
    String endDate,
    String prodId,
    String authToken,
  ) {
    return _dio.post(
      "workProgressionProductListFilter"
      "",
      params: {
        "companyId": companyId,
        "from": fromDate,
        "to": endDate,
        "productId": prodId,
        "mtoken": authToken,
      },
    );
  }
}
