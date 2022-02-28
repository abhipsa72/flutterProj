import 'package:dio/dio.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/network/dio_network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  final DioNetworkUtil _dio;

  LoginRepository(this._dio);

  Future<Response> loginUserNamePassword(
    String email,
    String password,
  ) =>
      _dio.postForm(
        "index.php?route=custom/customer/login",
        FormData.fromMap({
          'email': email,
          'password': password,
        }),
      );

  Future<Response> sessionLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return _dio.postForm(
      "index.php?route=api/login",
      FormData.fromMap({
        "username": prefs.getString(loginUserName),
        "key": prefs.getString(loginKey),
      }),
    );
  }

  Future<Response> getCurrencyCode() =>
      _dio.get("index.php?route=custom/currency");

  Future<Response> getCountryCode() =>
      _dio.get("index.php?route=custom/country");

  Future<Response> getLanguageCode() =>
      _dio.get("index.php?route=custom/language");

  Future<Response> setSessionCode(
    String languageId,
    String currencyId,
  ) =>
      _dio.postForm(
          "index.php?route=custom/customer/setSession",
          FormData.fromMap({
            'language_id': languageId,
            'currency_id': currencyId,
          }));

  Future<Response> register(
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
    String confirmPassword,
    bool isAgree,
    bool isNewsLetter,
  ) =>
      _dio.postForm(
        "index.php?route=custom/customer/registration",
        FormData.fromMap({
          'firstname': firstName,
          'lastname': lastName,
          'email': email,
          'telephone': phone,
          'password': password,
          'confirm': confirmPassword,
          'agree': isAgree ? 1 : 0,
          'newsletter': isNewsLetter ? 1 : 0,
        }),
      );

  Future<Response> forgotPasswordMail(String email) => _dio.postForm(
        "index.php?route=custom/account/forgottenPassword",
        FormData.fromMap({
          'email': email,
        }),
      );

  Future<Response> refresh() async {
    final prefs = await SharedPreferences.getInstance();
    print(
      "Refresh ${prefs.getString(userEmail)} ${prefs.getString(userPassword)}",
    );
    return loginUserNamePassword(
      prefs.getString(userEmail),
      prefs.getString(userPassword),
    );
  }
}
