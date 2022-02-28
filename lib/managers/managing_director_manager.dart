import 'package:dio/dio.dart';
import 'package:zel_app/managing_director/managing_director_provider.dart';
import 'package:zel_app/util/dio_network.dart';

class ManagingDirectorManaging {
  final _dio = DioNetworkUtil();

  Future<Response> getAllRole(String authToken) {
    return _dio.get(
      "getAllRole",
      params: {
        "mtoken": authToken,
      },
    );
  }

  Future<Response> getAllRegion(String authToken) {
    return _dio.get(
      "getAllRegion",
      params: {
        "mtoken": authToken,
      },
    );
  }

  Future<Response> lineChartForManagingDirector(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
    String storeName,
  ) {
    return _dio.post(
      apiState == ApiState.WithRegion ? "lineChartMD" : "lineChartMDbyStore",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "region": region ?? "Dubai",
        "storeName": storeName
      },
    );
  }

  Future<Response> getStoresByRegion(
    String authToken,
    String region,
  ) {
    return _dio.post(
      "getAllStoreOnRegion",
      params: {
        "mtoken": authToken,
        "region": region,
      },
    );
  }

  Future<Response> flowProgressionManagingDirector(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
    String companyId,
  ) {
    return _dio.post(
      apiState == ApiState.WithRegion
          ? "flowProgressionMD"
          : "flowProgressionStoreCodeMD",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "region": region ?? "Dubai",
        "companyId": companyId,
      },
    );
  }

  Future<Response> barChartManagingDirector(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
    String companyId,
    String storeName,
  ) {
    return _dio.post(
      apiState == ApiState.WithRegion ? "barChartMD" : "barChartMDbyStore",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "region": region ?? "Dubai",
        "companyId": companyId,
        "storeName": storeName
      },
    );
  }

  Future<Response> getSalesAlarms(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
  ) {
    return _dio.post(
      "getSalesAlarms",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "region": region ?? "Dubai",
      },
    );
  }

  Future<Response> getSalesAlarmRefresh(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
    String storeCode,
  ) {
    return _dio.post(
      "getSalesAlarmsBySCode",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "region": region ?? "Dubai",
        "storeCode": storeCode,
      },
    );
  }

  Future<Response> getWorkInProgressAlarms(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
    String storeCode,
  ) {
    return _dio.post(
      ApiState.WithRegion == apiState
          ? "getWIPAlrms"
          : "getWIPAlrmsByStoreCode",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "region": region ?? "Dubai",
        "storeCode": storeCode,
      },
    );
  }

  Future<Response> salesImpactChart(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
    String storeCode,
  ) {
    return _dio.post(
      apiState == ApiState.WithRegion
          ? "salesImpactChart"
          : "salesImpactChartByStore",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "region": region ?? "Dubai",
        "storeCode": storeCode,
      },
    );
  }

  Future<Response> getSalesAlarmsByStoreCode(
    String authToken,
    String storeCode,
    String fromDate,
    String endDate,
  ) {
    return _dio.post(
      "getSalesAlarmsBySCode",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "storeCode": storeCode,
      },
    );
  }

  Future<Response> salesImpactChartByStore(
    String authToken,
    String companyId,
    String fromDate,
    String endDate,
  ) {
    return _dio.post(
      "salesImpactChartByStore",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "companyId": companyId,
      },
    );
  }

  Future<Response> getWorkInProgressAlarmsByRole(
    String authToken,
    String roles,
    String fromDate,
    String endDate,
  ) {
    return _dio.post(
      "getWIPAlrmsByRole",
      params: {
        "mtoken": authToken,
        "from": fromDate,
        "to": endDate,
        "role": roles,
      },
    );
  }
}
