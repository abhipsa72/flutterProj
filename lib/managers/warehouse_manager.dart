import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/util/dio_network.dart';

class WarehouseManager {
  final _dio = DioNetworkUtil();

  Future<Response> warehouseDetails(
      String authToken, Roles roles, String fromDate, String endDate) async {
    return _dio.post(
      "flowProgressionByRole",
      params: {
        "role": describeEnum(roles),
        "from": fromDate,
        "to": endDate,
        "mtoken": authToken
      },
    );
  }

  Future<Response> filterAlaram(String authToken, Roles roles, String fromDate,
      String endDate, String value) {
    return _dio.post(
      "flowProgressionProductsByRole",
      params: {
        "mtoken": authToken,
        "role": describeEnum(roles),
        "from": fromDate,
        "to": endDate,
        "value": value
      },
    );
  }

  Future<Response> wareHouseProductList(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) async {
    return _dio.post(
      "getDataByRole",
      params: {
        "role": describeEnum(roles),
        "from": fromDate,
        "to": endDate,
        "mtoken": authToken
      },
    );
  }

  Future<Response> wareHouseActions(String authToken) async {
    return _dio.get(
      "getPermissionByRole",
      params: {"mtoken": authToken},
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
    String tId,
  ) {
    return _dio.post(
      "getPermissionByRole",
      params: {
        "mtoken": authToken,
        "tId": tId,
        "role": describeEnum(roles),
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

  Future<Response> getFilterProducts(
    String authToken,
    Roles roles,
    String department,
    String store,
    String fromDate,
    String endDate,
  ) {
    return _dio.post(
      "getDataByDivision",
      params: {
        "mtoken": authToken,
        "role": describeEnum(roles),
        "division": department,
        "companyId": store,
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
    Roles roles,
  ) {
    return _dio.post(
      "salesAlarmsByStoreCode",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "storeName": store,
        "role": describeEnum(roles),
      },
    );
  }

  Future<Response> getFilterByDepartment(
    String authToken,
    String fromDate,
    String endDate,
    String department,
    Roles roles,
  ) {
    return _dio.post(
      "salesAlarmsByDiv",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "division": department,
        "role": describeEnum(roles),
      },
    );
  }

  Future<Response> setWorkFlowToProduct(
    String workflowId,
    String authToken,
    String id,
    String targetDate,
  ) {
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
        "to": null,
      },
    );
  }
}
