import 'package:dio/dio.dart';

class StockOutManager {
  final dioNew = DioNetworkUtil();

  Future<Response> region() async {
    return dioNew.get("stkLogin/regions", params: {"uname": "arunoman"});
  }

  Future<Response> stores() async {
    return dioNew.post(
      "stkLogin/stores",
      params: {"uname": "arunoman", "rgn": "OMAN"},
    );
  }

  Future<Response> productSummary(
      String region, String store, String date) async {
    return dioNew.post(
      "stkLogin/summary",
      params: {
        "region": region ?? "UAE",
        "store": store ?? "0201",
        "date": date ?? "09/10/2021"
      },
    );
  }
}

handleError(DioError error) {
  if (error.response.statusCode == null) {
    return " ";
  }
  switch (error.response.statusCode) {
    case 302:
      return "Please login again.";
    case 500:
      return "wrong email or password";
    case 404:
      return "something went wrong";
    case 403:
      return 'Token expired';
    default:
      return "Something wrong please try again.";
  }
}

class DioNetworkUtil {
  Future<Response> get(String path, {Map<String, dynamic> params}) async {
    return await dioNew.get(
      path,
      queryParameters: params,
    );
  }

  Future<Response> post(String path,
      {Map<String, dynamic> data, Map<String, dynamic> params}) async {
    return await dioNew.post(
      path,
      data: data,
      queryParameters: params,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );
  }

  Future<Response> postForm(String path, FormData data,
      {Map<String, dynamic> params}) async {
    return await dioNew.post(
      path,
      data: data,
      queryParameters: params,
    );
  }

  Future<Response> put(String path,
      {Map<String, dynamic> data, Map<String, dynamic> params}) async {
    return await dioNew.put(
      path,
      data: data,
      queryParameters: params,
    );
  }

  Future<Response> delete(String path,
      {Map<String, dynamic> data, Map<String, dynamic> params}) async {
    return await dioNew.delete(
      path,
      data: data,
      queryParameters: params,
    );
  }

//  Future<Response> getHeader(String path,Options option,{Map<String, dynamic> params}) async{
//    return await dio.get(
//      path,
//      options: option,
//      queryParameters: params,
//    );
//  }
  Dio get dioNew {
    Dio dioNew = Dio();

    dioNew.options.baseUrl = "http://18.118.49.16/grandapi/api/";
    dioNew.options.connectTimeout = 100000;
    dioNew.options.receiveTimeout = 100000;

    dioNew.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) => requestInterceptor(options),
      ),
    );

    dioNew.interceptors.add(
      LogInterceptor(
          responseBody: true,
          requestHeader: true,
          responseHeader: true,
          requestBody: true,
          request: true,
          error: true),
    );
    return dioNew;
  }

  // Dio get dio {
  //   Dio _dio = Dio();
  //
  //   _dio.options.baseUrl = baseUrl;
  //   _dio.options.connectTimeout = 60000;
  //   _dio.options.receiveTimeout = 60000;
  //
  //   _dio.interceptors.add(
  //     InterceptorsWrapper(
  //       onRequest: (RequestOptions options) => requestInterceptor(options),
  //       onError: (error) async {
  //         /*FLog.info(
  //           text: 'Response: ${error.response.data}',
  //         );
  //         FLog.error(
  //           text: 'Error: ${error.error.toString()}',
  //         );*/
  //         if (error.response != null && error.response.statusCode == 403) {
  //           Box box;
  //           _dio.interceptors.requestLock.lock();
  //           _dio.interceptors.responseLock.lock();
  //           RequestOptions options = error.response.request;
  //           // Repository repository = locator<Repository>();
  //           DataManagerRepository _dataManagerRepository;
  //           String email = box.get(userEmailBoxKey);
  //           String password = box.get(userPasswordBoxKey);
  //           var result = await _dataManagerRepository.login(email, password);
  //           // (
  //           //     prefs.getString(userEmail),
  //           //     prefs.getString(userPassword),
  //           //   );
  //           LoginResponse user = LoginResponse.fromMap(result.data);
  //           box.put(authTokenBoxKey, user.user.authToken);
  //           // prefs.setString(apiToken, user.success.apiToken);
  //           options.headers['api-token'] = user.user.authToken;
  //
  //           _dio.interceptors.requestLock.unlock();
  //           _dio.interceptors.responseLock.unlock();
  //           return _dio.request(
  //             options.path,
  //             options: options,
  //           );
  //         } else {
  //           return error;
  //         }
  //       },
  //     ),
  //   );
  //   _dio.interceptors.add(LogInterceptor(
  //     requestBody: true,
  //     responseBody: true,
  //   ));
  //   _dio.interceptors.add(DioCacheManager(
  //     CacheConfig(baseUrl: baseUrl),
  //   ).interceptor);
  //   return _dio;
  // }

  requestInterceptor(RequestOptions options) async {
    //String token = prefs.getString(userAccessToken);
    //if (token != null) {
    //options.headers["Authorization"] = "Bearer " + token;
    //}
    //User-Agent: com.stacklighting.care.staging/1.9.0.6-staging (Xiaomi beryllium POCO F1; U; Android 10; QD1A.190821.014)
    //options.headers["User-Agent"] = userAgent;

    // set accept language
    //String lang = prefs.getString("lang");
    //if (lang != null) {
    //options.headers["Accept-Language"] = lang;
    //}
    //options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    return options;
  }
}
