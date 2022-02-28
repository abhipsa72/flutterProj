import 'package:dio/dio.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/util/dio_network.dart';

class ItManager {
  final _dio = DioNetworkUtil();

  Future<Response> ItDetails(String authToken,Roles roles,
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

  Future<Response> itProductList(String authToken,
      Roles roles,
      String fromDate,
      String endDate,) async {
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

  Future<Response> itActions(String authToken) async {
    return _dio.get(
      "getPermissionByRole",
      params: {"mtoken": authToken},
    );
  }

  Future<Response> setSupplierToProduct(String authToken,
      String productId,
      String supplierName,) {
    return _dio.post("setSupplierToProduct", params: {
      "mtoken": authToken,
      "pId": productId,
      "sName": supplierName,
    });
  }

//  Future<Response> getActionByPermission(String authToken, String id,) {
//    return _dio.post(
//      "getActionByPermission",
//      params: {
//        "id": id,
//        "mtoken": authToken,
//      },
//    );
//  }

  Future<Response> getPermissionsByRole(String authToken,
      Roles roles, String tId,) {
    return _dio.get(
      "getPermissionByRole",
      params: {
        "mtoken": authToken,
        "tId": tId,
        "role": rolesMap.reverse[roles],
      },
    );
  }

  Future<Response> getStores(String authToken,) {
    return _dio.get(
      "getAllStoreCode",
      params: {
        "mtoken": authToken,
      },
    );
  }

  Future<Response> getDepartments(String authToken,) {
    return _dio.get(
      "getAllDept",
      params: {
        "mtoken": authToken,
      },
    );
  }

  Future<Response> getFilterOfProducts(
      Roles roles,
      String authToken,
      int companyId,
      String department,
      String fromDate,
      String endDate,) {
    return _dio.post(
      "getDataByDivision",
      params: {
        "mtoken": authToken,
        "role": rolesMap.reverse[roles],
        "companyId": companyId,
        "department": department,
        "from": fromDate,
        "to": endDate,
      },
    );
  }

  Future<Response> setWorkFlowToProduct(String workflowId,
      String authToken,
      String id,
      String targetDate,) {
    return _dio.post(
      "setWorkFlowToProduct",
      params: {
        "wId": workflowId,
        "mtoken": authToken,
        "pId": id,
        "targetDate": targetDate,
      },
    );
  }

  Future<Response> actionTable(String authToken,
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