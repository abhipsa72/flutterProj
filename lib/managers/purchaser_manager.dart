import 'package:dio/dio.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/util/dio_network.dart';

class PurchaserManager {
  final _dio = DioNetworkUtil();

  Future<Response> purchaserDetails(
      String authToken, Roles roles, String fromDate, String endDate) async {
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

  Future<Response> purchaserProductList(
      String authToken, Roles roles, String fromDate, String endDate) async {
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

  Future<Response> setSupplier(
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

//  Future<Response> purchaserActions(String authToken) async {
//    return _dio.get(
//      "getPermissionByRole",
//      params: {"mtoken": authToken},
//    );
//  }
  Future<Response> getPermissionsByRole(
      String authToken, Roles roles, String tId) {
//    return _dio.getHeader("getPermissionByRole/${rolesMap.reverse[roles]}",
//        Options(
//          headers: {
//           "tId": threadId,
//// set content-length
//          },
//        ),
//        params: {
//          "mtoken": authToken,
//        }
//
//    );
    return _dio.post(
      "getPermissionByRole",
      params: {
        "mtoken": authToken,
        "tId": tId,
        "role": rolesMap.reverse[roles],
      },
    );
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

  Future<Response> asign(
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

  Future<Response> getStores(
    String authToken,
  ) {
    return _dio.get(
      "getAllStoreCode",
      params: {
        "mtoken": authToken,
      },
    );
  }

  Future<Response> getDepartments(
    String authToken,
  ) {
    return _dio.get(
      "getAllDept",
      params: {
        "mtoken": authToken,
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

  Future<Response> getFilterProducts(
    Roles roles,
    String authToken,
    int companyId,
    String division,
    String fromDate,
    String endDate,
  ) {
    return _dio.post(
      "getDataByDivision",
      params: {
        "mtoken": authToken,
        "role": rolesMap.reverse[roles],
        "companyId": companyId,
        "division": division,
        "from": fromDate,
        "to": endDate,
      },
    );
  }

  Future<Response> getFilterByScode(
    String authToken,
    String fromDate,
    String endDate,
    String store,
  ) {
    return _dio.post(
      "getSalesAlarmsBySCode",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "storeCode": store,
      },
    );
  }

  Future<Response> getFilterByDepartment(
    String authToken,
    String fromDate,
    String endDate,
    String department,
  ) {
    return _dio.post(
      "salesAlarmsByDiv",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "division": department,
      },
    );
  }

  Future<Response> purchaserActionTable(
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
        "role": rolesMap.reverse[roles],
        "to": null,
      },
    );
  }
}
