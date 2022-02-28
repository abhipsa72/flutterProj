import 'package:dio/dio.dart';
import 'package:zel_app/util/dio_network.dart';

class ProductsManager
{
  final _dio = DioNetworkUtil();

  Future<Response> mdProductList(
      String region,
      String fromDate,
      String endDate,
      String mToken
      ) {
    return _dio.post(
      "getSalesAlarms",
      params: {
        "region": region,
        "from": fromDate,
        "to": endDate,
        "mtoken": mToken
      },
    );
  }
  Future<Response> mdWIPList(
      String region,
      String fromDate,
      String endDate,
      String mToken
      ) {
    return _dio.post(
      "getWIPAlrms",
      params: {
        "region": region,
        "from": fromDate,
        "to": endDate,
        "mtoken": mToken
      },
    );
  }
  Future<Response> getStores(
      String authToken,
      String region
      ) {
    return _dio.get(
      "getAllStoreOnRegion",
      params: {
        "region" : region,
        "mtoken": authToken,
      },
    );
  }
  Future<Response> getRoles(
      String authToken,
      ) {
    return _dio.get(
      "getAllRole",
      params: {
        "mtoken": authToken,
      },
    );
  }
  Future<Response> getRegion(
      String authToken,
      ) {
    return _dio.get(
      "getAllRegion",
      params: {
        "mtoken": authToken,
      },
    );
  }
}