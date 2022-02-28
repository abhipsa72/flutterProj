import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/customer/model/login_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioNetworkUtil {
  Future<String> getCountryCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(selectedCountryCode) ?? 'grand_test';
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic> params,
    Options options,
  }) async {
    return await dio.get(
      "${await getCountryCode()}/$path",
      queryParameters: params,
      options: options,
    );
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic> data,
    Map<String, dynamic> params,
    Options options,
  }) async {
    return await dio.post(
      "${await getCountryCode()}/$path",
      data: data,
      queryParameters: params,
      options: options,
    );
  }

  Future<Response> postForm(
    String path,
    FormData data, {
    Map<String, dynamic> params,
    Options options,
  }) async {
    return await dio.post(
      "${await getCountryCode()}/$path",
      data: data,
      queryParameters: params,
      options: options,
    );
  }

  Future<Response> deleteForm(
    String path,
    FormData data, {
    Map<String, dynamic> params,
    Options options,
  }) async {
    return await dio.delete(
      "${await getCountryCode()}/$path",
      data: data,
      queryParameters: params,
      options: options,
    );
  }

  Future<Response> put(
    String path, {
    Map<String, dynamic> data,
    Map<String, dynamic> params,
    Options options,
  }) async {
    return await dio.put(
      "${await getCountryCode()}/$path",
      data: data,
      queryParameters: params,
      options: options,
    );
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic> data,
    Map<String, dynamic> params,
    Options options,
  }) async {
    return await dio.delete(
      "${await getCountryCode()}/$path",
      data: data,
      queryParameters: params,
      options: options,
    );
  }

  Dio get dio {
    Dio _dio = Dio();

    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 60000;
    _dio.options.receiveTimeout = 60000;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) => requestInterceptor(options),
        onError: (error) async {
          /*FLog.info(
            text: 'Response: ${error.response.data}',
          );
          FLog.error(
            text: 'Error: ${error.error.toString()}',
          );*/
          if (error.response != null && error.response.statusCode == 403) {
            final prefs = await SharedPreferences.getInstance();
            _dio.interceptors.requestLock.lock();
            _dio.interceptors.responseLock.lock();
            RequestOptions options = error.response.request;
            Repository repository = locator<Repository>();
            var result = await repository.loginUserNamePassword(
              prefs.getString(userEmail),
              prefs.getString(userPassword),
            );
            LoginResponse user = userFromJson(result.data);

            prefs.setString(apiToken, user.success.apiToken);
            options.headers['api-token'] = user.success.apiToken;

            _dio.interceptors.requestLock.unlock();
            _dio.interceptors.responseLock.unlock();
            return _dio.request(
              options.path,
              options: options,
            );
          } else {
            return error;
          }
        },
      ),
    );
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    _dio.interceptors.add(DioCacheManager(
      CacheConfig(baseUrl: baseUrl),
    ).interceptor);
    return _dio;
  }

  requestInterceptor(RequestOptions options) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(apiToken) ?? "";
    if (options.path.contains('admin'))
      token = prefs.getString(adminLoginToken) ?? "";
    print(token);
    options.headers['api-token'] = token;
    return options;
  }

  onErrorInterceptor(DioError error) async {
    if (error.response.statusCode == 403) {
      final prefs = await SharedPreferences.getInstance();
      dio.interceptors.requestLock.lock();
      dio.interceptors.responseLock.lock();
      RequestOptions options = error.response.request;
      Repository repository = locator<Repository>();
      var result = await repository.loginUserNamePassword(
          prefs.getString(userEmail), prefs.getString(userPassword));
      LoginResponse user = userFromJson(result.data);
      prefs.setString(apiToken, user.success.apiToken);
      options.headers['api-token'] = user.success.apiToken;
      dio.interceptors.requestLock.unlock();
      dio.interceptors.responseLock.unlock();
      return dio.request(options.path, options: options);
    }
    return error;
  }
}

bool sessionError(DioError error) {
  //{error: {warning: Warning: You do not have permission to access the API!}
  print("Hemanth: ${error.message}");
  if (error.response.data['error']['warning'] ==
          "Warning: You do not have permission to access the API!" &&
      error.response.statusCode == 401) {
    return true;
  } else {
    return false;
  }
}

/*
old token
* if (error.response.statusCode == 401) {
      var options = error.request;
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(apiToken) ?? "";
      if (token != options.headers['api-token']) {
        options.headers["api-token"] = token;
        //repeat
        return dio.request(options.path, options: options);
      }
      // update token and repeat
      // Lock to block the incoming request until the token updated
      dio.interceptors.requestLock.lock();
      dio.interceptors.responseLock.lock();
      Repository repository = locator<Repository>();
      repository
          .loginUserNamePassword(
              prefs.getString(userEmail), prefs.getString(userPassword))
          .then((result) {
        User user = userFromJson(result.data);
        prefs.setString(apiToken, user.success.apiToken);
        options.headers["api-token"] = user.success.apiToken;
      }).whenComplete(() {
        dio.interceptors.requestLock.unlock();
        dio.interceptors.responseLock.unlock();
      }).then((value) {
        return dio.request(options.path, options: options);
      });
    }
* */
