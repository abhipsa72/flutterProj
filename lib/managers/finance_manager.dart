import 'package:dio/dio.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/util/dio_network.dart';

class FinanceManager {
  final _dio = DioNetworkUtil();

  Future<Response> financeDetails(String authToken,  Roles roles,
      String fromDate, String endDate) async {
    return _dio.post(
      "flowProgressionByRole",
      params: {
        "role": rolesMap.reverse[roles],
        "from": fromDate,
        "to": endDate,
        "mtoken": authToken
      },
    );
  }
  Future<Response> filterAlaram(String authToken,Roles roles,String fromDate,String endDate, String value) {
    return _dio.post(
      "flowProgressionProductsByRole",
      params: {
        "mtoken": authToken,
        "role": rolesMap.reverse[roles],
        "from": fromDate,
        "to": endDate,
        "value": value
      },
    );
  }
  Future<Response> financeProductList(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) async {
    return _dio.post(
      "getDataByRole",
      params: {
        "role": rolesMap.reverse[roles],
        "from": null,
        "to": null,
        "mtoken": authToken
      },
    );
  }

  Future<Response> financeActions(
    String authToken,
    Roles roles,
      String tId,
  ) async {
    return _dio.post(
      "getPermissionByRole",
      params: {
        "mtoken": authToken,
        "tId": tId,
        "role": rolesMap.reverse[roles],
      },
    );
  }

  Future<Response> setSupplierToProduct(
    String authToken,
    String productId,
    String supplierName,
  ) {
    return _dio.post("setSupplierToProduct", params: {
      "mtoken": authToken,
      "pId": productId,
      "sName": supplierName,
    });
  }

  Future<Response> getActionByPermission(
    String authToken,
    String id,
  ) {
    return _dio.post(
      "getActionByPermission",
      params: {
        "id": id,
        "mtoken": authToken,
      },
    );
  }

  Future<Response> getPermissionsByRole(
    String authToken,
    Roles roles,
  ) {
    return _dio.get(
      "getPermissionByRole/${rolesMap.reverse[roles]}",
      params: {
        "mtoken": authToken,
      },
    );
  }

//  Future<Response> getStores(
//      String authToken,
//      ) {
//    return _dio.get(
//      "getAllStoreCode",
//      params: {
//        "mtoken": authToken,
//      },
//    );
//  }

  Future<Response> getSupplier(
    String authToken,
  ) {
    return _dio.get(
      "getAllSupplier",
      params: {
        "mtoken": authToken,
      },
    );
  }

  Future<Response> getFilterOfProduct(
    Roles roles,
    String authToken,
    String supplierName,
  ) {
    return _dio.post(
      "getDataByDivision",
      params: {
        "mtoken": authToken,
        "role": rolesMap.reverse[roles],
        "sName": supplierName,
      },
    );
  }

  Future<Response> setWorkFlowToProduct(
    String authToken,
    String productId,
    String workflowId,
    String targetDate,
  ) {
    return _dio.post(
      "setWorkFlowToProduct",
      params: {
        "wId": workflowId,
        "mtoken": authToken,
        "pId": productId,
        "targetDate": targetDate,
      },
    );
  }

  Future<Response> financeSubActions(
    String authToken,
    String actionId,
  ) {
    return _dio.post(
      "getActionByPermission",
      params: {
        "id": actionId,
        "mtoken": authToken,
      },
    );
  }

  Future<Response> finanaceActionTable(String authToken,
      Roles roles,
      String fromDate,
      String endDate,) {
    return _dio.post(
      "getWIPAlrmsByRole",
      params: {
        "from": null,
        "mtoken": authToken,
        "role": rolesMap.reverse[roles],
        "to": null,
      },
    );
  }
}
