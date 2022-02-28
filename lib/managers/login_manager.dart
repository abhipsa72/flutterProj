import 'package:dio/dio.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/util/dio_network.dart';

class LoginManager {
  DioNetworkUtil _dio = DioNetworkUtil();
  Future<Response> languages() async {
    return _dio.get("$languagesUrl");
  }

  Future<Response> selectedLanguage(String lang) async {
    return _dio.get("getLanguage/$lang");
  }

  Future<Response> login(String email, String password) async {
    return _dio.post(
      loginUrl,
      params: {
        "username": email,
        "password": password,
      },
    );
  }

  Future<Response> registerAccount(String fullName, String email,
      String phoneNumber, String password) async {
    return _dio.post(
      "saveMongoUser",
      params: {
        "name": fullName,
        "emailId": email,
        "password": password,
        "contactNumber": phoneNumber
      },
    );
  }

  Future<Response> forgotPassword(String email) {
    return _dio.post(
        "verify",
        params: {
        "credential": email,
        },
    );
  }

  Future<Response> verifyOtp(String emailOrNumber, String otp) {
    return _dio.post(
      "verifyOtpEntered",
      params: {
        "credential": emailOrNumber,
        "otp": otp,
      },
    );
  }

  Future<Response> changePassword(String emailOrNumber, String password) {
    return _dio.post(
      "passwordChange",
      params: {
        "credential": emailOrNumber,
        "password": password,
      },
    );
  }
}
