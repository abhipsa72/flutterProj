import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zel_app/common/loading.dart';
import 'package:zel_app/intro/forgot_password/change_password.dart';
import 'package:zel_app/intro/forgot_password/otp_verify_page.dart';
import 'package:zel_app/managers/repository.dart';

class PasswordChangeProvider extends Loading {
  DataManagerRepository _repository;

  PasswordChangeProvider(this._repository);

  forgotPassword(BuildContext context, emailOrNmber) async {
    setLoading(true);
    try {
      final result = await _repository.forgotPassword(emailOrNmber);
      setLoading(false);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpVerifyPage(emailOrNmber)),
      );
    } on DioError catch (error) {
      debugPrint("$error");
      setLoading(false);
    }
  }

  changePassword(
      BuildContext context, String emailOrNumber, String password) async {
    setLoading(true);
    try {
      final result = await _repository.changePassword(emailOrNumber, password);
      setLoading(false);
    } on DioError catch (error) {
      debugPrint("$error");
      setLoading(false);
    }
  }

  otpVerify(BuildContext context, String emailOrNumber, String otp) async {
    setLoading(true);
    try {
      final result = await _repository.verifyOtp(emailOrNumber, otp);
      setLoading(false);
      Navigator.of(context)
          .pushNamed(ChangePasswordPage.routeName, arguments: emailOrNumber);
    } on DioError catch (error) {
      debugPrint("$error");
      setLoading(false);
    }
  }
}
