import 'package:dio/dio.dart';
import 'package:zel_app/util/dio_network.dart';

class RcaManager {
  final _dio = DioNetworkUtil();

  Future<Response> rcaOnRegion(
    String authToken,
  ) {
    return _dio.get(
      "rcaOnRegion",
      params: {
        "mtoken": authToken,
      },
    );
  }

  Future<Response> rcaOnStore(
    String authToken,
    String id,
  ) {
    return _dio.post(
      "rcaOnStore",
      params: {
        "rId": id,
        "mtoken": authToken,
      },
    );
  }

  Future<Response> rcaOnDepartment(
    String authToken,
    String id,
  ) {
    return _dio.post(
      "rcaOnDepartment",
      params: {
        "sId": id,
        "mtoken": authToken,
      },
    );
  }

  Future<Response> rcaOnSection(String authToken, String id, String deptId) {
    return _dio.post(
      "rcaOnSection",
      params: {
        "sId": id,
        "mtoken": authToken,
        "dId": deptId,
      },
    );
  }

  Future<Response> rcaOnCategory(
      String authToken, String id, String sectionId) {
    return _dio.post(
      "rcaOnCategory",
      params: {
        "sId": id,
        "mtoken": authToken,
        "sectionId": sectionId,
      },
    );
  }

  Future<Response> rcaOnSubCategory(
      String authToken, String id, String categoryId) {
    return _dio.post(
      "rcaOnSubCategory",
      params: {
        "sId": id,
        "mtoken": authToken,
        "cId": categoryId,
      },
    );
  }

  Future<Response> rcaOnProduct(
      String authToken, String id, String subcategoryId) {
    return _dio.post(
      "rcaOnProduct",
      params: {
        "mtoken": authToken,
        "sId": id,
        "subcategoryId": subcategoryId,
      },
    );
  }

  Future<Response> rcaOnProductGraph(
      String authToken, String id, String subcategoryId) {
    return _dio.post(
      "rcaOnProductGraph",
      params: {
        "mtoken": authToken,
        "sId": id,
        "subcategoryId": subcategoryId,
      },
    );
  }
}
